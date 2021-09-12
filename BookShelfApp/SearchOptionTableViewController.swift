//
//  SearchOptionTableViewController.swift
//  BookShelfApp
//
//  Created by 加藤将斗 on 2021/09/12.
//

import UIKit

class SearchOptionTableViewController: UITableViewController {
    
    @IBOutlet var searchOptionTableView: UITableView!
    
    let userDefaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchOptionTableView.register(UINib(nibName: "SearchOptionTableViewCell", bundle: nil), forCellReuseIdentifier: "OptionCell")
        
        
        
        
        
        
    }
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = searchOptionTableView.dequeueReusableCell(withIdentifier: "OptionCell", for: indexPath) as! SearchOptionTableViewCell
        
        cell.selectionStyle = .none
        cell.optionLabel.text = "追加後に「本の追加」画面を閉じる"
        
        let switchStatus = userDefaults.bool(forKey: "switchStatus")
        cell.optionSwitch.setOn(switchStatus, animated: false)
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        
        return "オンにすると、本を追加後に「本の追加」画面を自動で閉じます、オフにすると、「本の追加」画面を開いたまま連続で本を追加できます。"
        
    }

}
