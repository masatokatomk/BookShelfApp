//
//  ViewController.swift
//  BookShelfApp
//
//  Created by 加藤将斗 on 2021/08/28.
//

import UIKit
import Realm
import RealmSwift

class BookShelfViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var bookShelfTableView: UITableView!
    
    let realm = try! Realm()
    let user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookShelfTableView.delegate = self
        bookShelfTableView.dataSource = self
        
        let userData = realm.objects(User.self)
        print("🟥全てのデータ_viewDidLoad\(userData)")
        
        bookShelfTableView.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let userData = realm.objects(User.self)
        print("🟥全てのデータ_viewWillAppear\(userData)")
        bookShelfTableView.reloadData()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let userData = realm.objects(User.self)
        return userData.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = bookShelfTableView.dequeueReusableCell(withIdentifier: "BookShelfCell", for: indexPath) as! BookShelfTableViewCell
        let userData = realm.objects(User.self)
        
        //ハイライトを消す
        cell.selectionStyle = .none
        
        do {
            
            let readImageUrl = URL(string:  userData[indexPath.row].imageURL)
            let readImagePath = readImageUrl?.path
            cell.bookShelfImageView.image = UIImage(contentsOfFile: readImagePath!)
            
        }
        
        cell.bookShelfTitleLabel.text = userData[indexPath.row].title
        cell.bookShelfAuthorLabel.text = userData[indexPath.row].author
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailVC = storyboard?.instantiateViewController(identifier: "Detail") as! DetailViewController
        detailVC.bookShelfIndexPath = indexPath.row
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return view.frame.size.height / 6
        
    }
    
    @IBAction func bookSearch(_ sender: UIBarButtonItem) {
        
        let searchVC = storyboard?.instantiateViewController(identifier: "BookSearch") as! SearchViewController
        navigationController?.pushViewController(searchVC, animated: true)
        
    }
    
    
    
    
    
    
}

