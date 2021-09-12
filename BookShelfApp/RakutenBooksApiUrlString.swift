//
//  RakutenBooksApiUrlString.swift
//  BookShelfApp
//
//  Created by 加藤将斗 on 2021/09/12.
//

import Foundation

func rakutenBooksApiUrlString(keyWordApi: String, pageApi: Int) -> String {
    
    //URLに使用できない文字列があるかもしれないのでエンコードする
    let keywordEncodeString = keyWordApi.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)
    
    let booksGenreId = "001"
    let sort = "-releaseDate"
    let outOfStockFlag = "1"
    let applicationId = "1055015994202844181"
    
    let urlString =  "https://app.rakuten.co.jp/services/api/BooksBook/Search/20170404?format=json&title=\(keywordEncodeString!)&booksGenreId=\(booksGenreId)&page=\(pageApi)&sort=\(sort)&outOfStockFlag=\(outOfStockFlag)&applicationId=\(applicationId)"
    
    return urlString
    
}
