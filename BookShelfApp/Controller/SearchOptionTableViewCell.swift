//
//  SearchOptionTableViewCell.swift
//  BookShelfApp
//
//  Created by 加藤将斗 on 2021/09/12.
//

import UIKit

class SearchOptionTableViewCell: UITableViewCell {

    @IBOutlet weak var optionLabel: UILabel!
    @IBOutlet weak var optionSwitch: UISwitch!
    
    let userDefaults = UserDefaults.standard
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func switchStatus(_ sender: UISwitch) {
        
        userDefaults.set(sender.isOn, forKey: "switchStatus")
        
    }
    
    
}
