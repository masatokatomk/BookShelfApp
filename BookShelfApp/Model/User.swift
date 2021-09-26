//
//  User.swift
//  BookShelf
//
//  Created by 加藤将斗 on 2021/08/23.
//

import Foundation
import RealmSwift

class User: Object {
    
    @objc dynamic var imageURL: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var author: String = ""
    @objc dynamic var publisher: String = ""
    @objc dynamic var releaseDate: String = ""
    
}
