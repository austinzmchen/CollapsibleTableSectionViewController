//
//  BasicExampleViewController.swift
//  Examples
//
//  Created by Yong Su on 7/21/17.
//  Copyright © 2017 jeantimex. All rights reserved.
//

import UIKit
import CollapsibleTableSectionViewController

class BasicExampleViewController: CollapsibleTableSectionViewController {
    
    var sections: [Section] = sectionsData
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.clpDelegate = self
    }
    
}

extension BasicExampleViewController: CollapsibleTableSectionDelegate {
    func collapsibleTableView(_ tableView: UITableView, sectionInfoAt section: Int) -> TableSection? {
        return nil
    }
    
    func collapsibleTableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func collapsibleTableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    func collapsibleTableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func collapsibleTableView(_ tableView: UITableView, didSelectSectionHeaderAt section: Int) {}
    
    func collapsibleTableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
    
    func shouldCollapseByDefault(_ tableView: UITableView, section: Int) -> Bool {
        return true
    }
    
    func shouldCollapseOthers(_ tableView: UITableView) -> Bool {
        return false
    }
    
    
    func numberOfSections(_ tableView: UITableView) -> Int {
        return sections.count
    }
    
    func collapsibleTableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    func collapsibleTableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell") as UITableViewCell? ?? UITableViewCell(style: .subtitle, reuseIdentifier: "BasicCell")
        
        let item: Item = sections[indexPath.section].items[indexPath.row]
        
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = item.detail
        
        return cell
    }
    
    func collapsibleTableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].name
    }

}
