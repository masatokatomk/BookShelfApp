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
    
    let booksGenreId = "001" //ジャンルを本に指定
    let sort = "-releaseDate" //発売日が新しい順
    let outOfStockFlag = "1" //購入不可の商品も検索結果に表示する
    let applicationId = "1055015994202844181" 
    
    let urlString = "https://app.rakuten.co.jp/services/api/BooksTotal/Search/20170404?format=json&keyword=\(keywordEncodeString!)&booksGenreId=\(booksGenreId)&sort=\(sort)&outOfStockFlag=\(outOfStockFlag)&page=\(pageApi)&applicationId=\(applicationId)"
    
    return urlString
    
}
