//
//  SearchTableViewController.swift
//  BookShelfApp
//
//  Created by 加藤将斗 on 2021/08/28.
//

import UIKit
import Alamofire
import Realm
import RealmSwift
import SDWebImage
import SwiftyJSON

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,  UISearchBarDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var bookSearchTableView: UITableView!
    @IBOutlet weak var bookSearchBar: UISearchBar!
    
    let realm = try! Realm()
    
    let userDefaults = UserDefaults.standard
    var switchStatus: Bool = true
    
    var imageList: [String] = []
    var titleList: [String] = []
    var authorList: [String] = []
    var publisherList: [String] = []
    var releaseDateList: [String] = []
    var isbnList: [String] = []
    
    var pageCountAll: Int = 0
    var page: Int = 0
    
    var reloadCount: Int = 0
    var loading: Bool = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookSearchTableView.dataSource = self
        bookSearchTableView.delegate = self
        bookSearchBar.delegate = self
        
        //bookSearchBarに何も入力されてない場合はreturnキーは押せない。
        bookSearchBar.enablesReturnKeyAutomatically = true
        bookSearchBar.placeholder = "検索(タイトル)"
        
        switchStatus = userDefaults.bool(forKey: "switchStatus")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        switchStatus = userDefaults.bool(forKey: "switchStatus")
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        reloadCount += 1
        print("セルの数", titleList.count, reloadCount)
        return titleList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchTableViewCell
        
        cell.apiImageView.sd_setImage(with: URL(string: imageList[indexPath.row]), completed: nil)
        cell.apiTitleLabel.text = titleList[indexPath.row]
        cell.apiAuthorLabel.text = authorList[indexPath.row]
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let savingImageUrl = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("bookImage_\(isbnList[indexPath.row]).jpeg") else {
            print("ファイルの生成に失敗しました。")
            return
        }
        
        let imageData = getImageByUrl(url: imageList[indexPath.row]).jpegData(compressionQuality: 0.9)
        
        do {
            
            try imageData?.write(to: savingImageUrl)
            
            
        } catch let error {
            
            print("画像の保存に失敗しました。", error)
            
        }
        
        try! self.realm.write {
            
            let user = User()
            user.imageURL = savingImageUrl.absoluteString
            user.title = titleList[indexPath.row]
            user.author = authorList[indexPath.row]
            user.publisher = publisherList[indexPath.row]
            user.releaseDate = releaseDateList[indexPath.row]
            realm.add(user)
            
        }
        
        if switchStatus == true {
            
            navigationController?.popToRootViewController(animated: true)
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return view.frame.size.height / 6
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        bookSearchBar.endEditing(true)
        pageCountAll = 0
        page = 0
        removeAllList()
        bookSearchTableView.reloadData()
        getBookData(keyWord: bookSearchBar.text!, pageGetBookData: page)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let currentOffsetY = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.height
        let distanceToBottom = maximumOffset - currentOffsetY
        if(distanceToBottom < 500 && self.loading == true){
            
            if page < pageCountAll {
                
                self.loading = false
                getBookData(keyWord: self.bookSearchBar.text!, pageGetBookData: page)
                
            }
            
        }
        
    }
    
    func getBookData(keyWord:String, pageGetBookData:Int){
        
        let urlString = rakutenBooksApiUrlString(keyWordApi: keyWord, pageApi: pageGetBookData + 1)
        
        //Alamofireを使ってhttpリクエスト
        AF.request(urlString, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (response) in
            
            switch response.result{
            
            case .success:
                let json:JSON = JSON(response.data as Any)
                
                print("代入前のpageCount", json["pageCount"].int!)
                self.pageCountAll = json["pageCount"].int! //検索総ページ数
                self.page = json["page"].int! //検索結果現在のページ
                
                let count = json["count"].int! //検索総ヒット数
                let hits = json["hits"].int! //検索結果現在のページのヒット数
                
                print("検索ヒット数", count)
                print("総ページ数は\(self.pageCountAll)ページで、\(self.page)ページ目です。")
                print("hits", hits)

                
                if hits > 1 {
                    
                    for item in 0 ... hits - 1 {
                        
                        self.imageList.append(json["Items"][item]["Item"]["largeImageUrl"].string!)
                        self.titleList.append(json["Items"][item]["Item"]["title"].string!)
                        self.authorList.append(json["Items"][item]["Item"]["author"].string!)
                        self.publisherList.append(json["Items"][item]["Item"]["publisherName"].string!)
                        self.releaseDateList.append(json["Items"][item]["Item"]["salesDate"].string!)
                        self.isbnList.append(json["Items"][item]["Item"]["isbn"].string!)
                        
                        if item == hits - 1 {
                            
                            print("リロードします")
                            
                            print(self.imageList[0 + 30 * (self.page - 1) ..< hits + 30 * (self.page - 1)])
                            print(self.titleList[0 + 30 * (self.page - 1) ..< hits + 30 * (self.page - 1)])
                            print(self.authorList[0 + 30 * (self.page - 1) ..< hits + 30 * (self.page - 1)])
                            print(self.publisherList[0 + 30 * (self.page - 1) ..< hits + 30 * (self.page - 1)])
                            print(self.releaseDateList[0 + 30 * (self.page - 1) ..< hits + 30 * (self.page - 1)])
                            print(self.isbnList[0 + 30 * (self.page - 1) ..< hits + 30 * (self.page - 1)])
                            
                        }
                        
                    }
                    
                }else if hits == 1 {
                    
                    self.imageList.append(json["Items"][hits - 1]["Item"]["largeImageUrl"].string!)
                    self.titleList.append(json["Items"][hits - 1]["Item"]["title"].string!)
                    self.authorList.append(json["Items"][hits - 1]["Item"]["author"].string!)
                    self.publisherList.append(json["Items"][hits - 1]["Item"]["publisherName"].string!)
                    self.releaseDateList.append(json["Items"][hits - 1]["Item"]["salesDate"].string!)
                    self.isbnList.append(json["Items"][hits - 1]["Item"]["isbn"].string!)
                    
                    print("リロードします")
                    
                    print(self.imageList[0 + 30 * (self.page - 1) ..< hits + 30 * (self.page - 1)])
                    print(self.titleList[0 + 30 * (self.page - 1) ..< hits + 30 * (self.page - 1)])
                    print(self.authorList[0 + 30 * (self.page - 1) ..< hits + 30 * (self.page - 1)])
                    print(self.publisherList[0 + 30 * (self.page - 1) ..< hits + 30 * (self.page - 1)])
                    print(self.releaseDateList[0 + 30 * (self.page - 1) ..< hits + 30 * (self.page - 1)])
                    print(self.isbnList[0 + 30 * (self.page - 1) ..< hits + 30 * (self.page - 1)])
                    
                } else {
                    print("検索結果は0件です。")
                    
                }
                
                self.bookSearchTableView.reloadData()
                self.loading = true
                
            case .failure(let error):
                print("error", error)
                
            }
            
        }
        
    }
    
    func removeAllList() {
        
        imageList.removeAll()
        titleList.removeAll()
        authorList.removeAll()
        publisherList.removeAll()
        releaseDateList.removeAll()
        isbnList.removeAll()
        
    }
    
    @IBAction func searchOption(_ sender: UIBarButtonItem) {
        
        let searchOptionVC = storyboard?.instantiateViewController(identifier: "SearchOption") as! SearchOptionTableViewController
        navigationController?.pushViewController(searchOptionVC, animated: true)
        
    }
    
}
