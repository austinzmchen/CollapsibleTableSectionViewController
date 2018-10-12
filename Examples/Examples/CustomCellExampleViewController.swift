//
//  CustomCellExampleViewController.swift
//  Examples
//
//  Created by Yong Su on 7/30/17.
//  Copyright © 2017 jeantimex. All rights reserved.
//

import UIKit
import CollapsibleTableSectionViewController

class CustomCellExampleViewController: CollapsibleTableSectionViewController {
    
    var sections: [Section] = sectionsData
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.clpDelegate = self
    }
    
}

extension CustomCellExampleViewController: CollapsibleTableSectionDelegate {
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
        let cell: CustomCell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? CustomCell ??
            CustomCell(style: .default, reuseIdentifier: "Cell")
        
        let item: Item = sections[(indexPath as NSIndexPath).section].items[(indexPath as NSIndexPath).row]
        
        cell.nameLabel.text = item.name
        cell.detailLabel.text = item.detail
        
        return cell
    }
    
    func collapsibleTableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].name
    }
    
}
