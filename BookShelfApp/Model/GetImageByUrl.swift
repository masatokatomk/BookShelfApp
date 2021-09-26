//
//  GetImageByUrl.swift
//  BookShelfApp
//
//  Created by 加藤将斗 on 2021/08/29.
//

import Foundation
import UIKit

func getImageByUrl(url: String) -> UIImage{
    
    let url = URL(string: url)
    do {
        
        let data = try Data(contentsOf: url!)
        return UIImage(data: data)!
        
    } catch let error {
        print("Error : \(error.localizedDescription)")
    }
    
    return UIImage()
}
