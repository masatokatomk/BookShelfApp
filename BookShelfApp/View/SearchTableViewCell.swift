//
//  SearchTableViewCell.swift
//  BookShelfApp
//
//  Created by 加藤将斗 on 2021/08/29.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var apiImageView: UIImageView!
    @IBOutlet weak var apiTitleLabel: UILabel!
    @IBOutlet weak var apiAuthorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
