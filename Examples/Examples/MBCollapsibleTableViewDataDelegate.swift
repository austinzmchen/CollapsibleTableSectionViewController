//
//  MBCollapsibleTableViewDataDelegate.swift
//  MBNA
//
//  Created by Austin Chen on 2018-01-24.
//  Copyright © 2018 Austin Chen. All rights reserved.
//

import UIKit
import CollapsibleTableSectionViewController

class MBCollapsibleTableViewDataDelegate: CollapsibleTableViewDataDelegate {
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "kMBCollapsibleTableViewHeader") as! MBCollapsibleTableViewHeader
        
        guard let sectionInfo = tView.clpDelegate?.collapsibleTableView(tableView, sectionInfoAt: section)
            else { return header }
        
        header.titleLabel.text = sectionInfo.name
        if sectionInfo.icon == "user_icon" {
            header.titleLabel.font = UIFont.systemFont(ofSize: 23)
            header.titleLabel.numberOfLines = 2
        }
        header.leftImageView.image = UIImage(named: sectionInfo.icon)
        
        //
        if sectionInfo.name ~= NSLocalizedString("Login & Security", comment: "") {
            header.separatorStyle = .none
        }
        else if section + 1 == tView.clpDelegate?.numberOfSections(tableView) ?? 0 {
            header.separatorStyle = .none
        }
        else {
            header.separatorStyle = .normal
        }
        
        // collapse status
        if sectionInfo.items.count == 0 {
            header.collapseStatus = .incollapsible
        } else {
            if tView.isSectionCollapsed(section) {
                header.collapseStatus = .collapsed
            } else {
                header.collapseStatus = .expanded
            }
        }
        
        header.section = section
        header.delegate = (tView as? CollapsibleTableViewHeaderDelegate)
        
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {

        var footer: MBCollapsibleTableViewFooter?
        
        if let sectionInfo = tView.clpDelegate?.collapsibleTableView(tableView, sectionInfoAt: section),
            sectionInfo.name ~= NSLocalizedString("Login & Security", comment: "") {
            
            let reusableFooter = tableView.dequeueReusableHeaderFooterView(withIdentifier: "kMBCollapsibleTableViewFooter") as! MBCollapsibleTableViewFooter
            reusableFooter.versionNumber.isHidden = true
            var frame = reusableFooter.frame
            frame.size = CGSize(width: frame.size.width, height: 10)
            reusableFooter.frame = frame
            footer = reusableFooter
        }
        else if (tableView.numberOfSections - 1) == section {
            let reusableFooter = tableView.dequeueReusableHeaderFooterView(withIdentifier: "kMBCollapsibleTableViewFooter") as! MBCollapsibleTableViewFooter
            reusableFooter.versionNumber.isHidden = false
            reusableFooter.versionNumber.text = "Version 0.0.1"
            footer = reusableFooter
        }
        return footer
    }
    
}
