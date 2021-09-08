//
//  DetailViewController.swift
//  BookShelfApp
//
//  Created by 加藤将斗 on 2021/08/29.
//

import UIKit
import Realm
import RealmSwift

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailTitleLabel: UILabel!
    @IBOutlet weak var detailAuthorLabel: UILabel!
    @IBOutlet weak var detailPublisherLabel: UILabel!
    @IBOutlet weak var detailReleaseDateLabel: UILabel!
    
    let realm = try! Realm()
    let user = User()
    
    var bookShelfIndexPath: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userData = realm.objects(User.self)
        
        do {
            
            let readImageUrl = URL(string:  userData[bookShelfIndexPath].imageURL)
            let readImagePath = readImageUrl?.path
            detailImageView.image = UIImage(contentsOfFile: readImagePath!)
            
        }
        
        detailTitleLabel.text = userData[bookShelfIndexPath].title
        detailAuthorLabel.text = userData[bookShelfIndexPath].author
        detailPublisherLabel.text = userData[bookShelfIndexPath].publisher
        detailReleaseDateLabel.text = userData[bookShelfIndexPath].releaseDate
        
    }
    
    @IBAction func deleteButtonTapped(_ sender: UIBarButtonItem) {
        
        let bookDeleteAlertController = UIAlertController(title: "本を削除", message: "この本をMy本棚から削除しますか?", preferredStyle: .alert)
        
        //「いいえ」ボタン
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: { (action: UIAlertAction) in
            
            //「いいえ」ボタンをタップした時は処理なし
            
        })
        //「はい」ボタンをタップすると削除するので赤文字にする
        let deleteAction = UIAlertAction(title: "削除", style: .destructive, handler: { (action: UIAlertAction) in
            
            //「はい」ボタンをタップした時の処理
            let userData = self.realm.objects(User.self)
            
            do {
                
                let deleteImageUrl = URL(string:  userData[self.bookShelfIndexPath].imageURL)
                let deleteImagePath = deleteImageUrl?.path
                
                if deleteImagePath != nil {
                    try? FileManager.default.removeItem(atPath: deleteImagePath!)
                }
                
            }
            
            try! self.realm.write {
                self.realm.delete(userData[self.bookShelfIndexPath])
            }
            
            self.navigationController?.popToRootViewController(animated: true)
            
        })
        
        //bookDeleteAlertControllerに「いいえ」、「はい」ボタンを追加
        bookDeleteAlertController.addAction(cancelAction)
        bookDeleteAlertController.addAction(deleteAction)
        
        //実際にbookDeleteAlertControllerを表示
        present(bookDeleteAlertController, animated: true, completion: nil)
        
    }
    
}
