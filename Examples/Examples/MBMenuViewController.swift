//
//  MBMenuViewController.swift
//  MBNA
//
//  Created by Austin Chen on 2017-12-07.
//  Copyright © 2017 Austin Chen. All rights reserved.
//

import UIKit
import CollapsibleTableSectionViewController

struct SideMenuRowDescriptor {
    let title : String
    let imageName : String
    let url : String?
}

class MBMenuViewController: UIViewController {

    @IBOutlet private weak var tableView: MBCollapsibleTableView!
    
    private var numberOfAccounts: Int = 0

    var sections: [TableSection] =  MBMenuViewController.loggedInSectionInfos

    var isShownLoggedInMenuItems = false {
        didSet {
            tableView.reloadSections()
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.clpDelegate = self
        self.isShownLoggedInMenuItems = false
    }
}

extension MBMenuViewController: CollapsibleTableSectionDelegate {

    func shouldCollapseOthers(_ tableView: UITableView) -> Bool {
        return true
    }

    func numberOfSections(_ tableView: UITableView) -> Int {
        return sections.count
    }

    func collapsibleTableView(_ tableView: UITableView, sectionInfoAt section: Int) -> TableSection {
        let section: TableSection = sections[section]
        if section.icon == "user_icon" {
            section.name = "John Appleseed"
        } else {
            updateName(inSection: section)
        }
        return section
    }

    func collapsibleTableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }

    func collapsibleTableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "kMBMenuTableCell") as! MBMenuTableCell

        let item: TableItem = sections[(indexPath as NSIndexPath).section].items[(indexPath as NSIndexPath).row]

        cell.titleLabel.text = item.name
        return cell
    }

    // header/footer
    func collapsibleTableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

        var height: CGFloat = 62.0
        let section: TableSection = sections[section]

        if section.icon == "user_icon" {
            height = 110
        }
        return height
    }

    func collapsibleTableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {

        var height: CGFloat = 0
        let sectInfo: TableSection = sections[section]

        if sectInfo.name == NSLocalizedString("Login & Security", comment: "") {
            height = kLogoutFooterViewHeight
        }

        if (sections.count-1) == section {
            height = kVersionFooterViewHeight
        }
        return height
    }

    func shouldCollapseByDefault(_ tableView: UITableView, section: Int) -> Bool {
        return true
    }

    // action
    func collapsibleTableView(_ tableView: UITableView, didSelectSectionHeaderAt section: Int) {

        let sectionInfo = sections[section]

        // do nothing if user tapped on user cell, or tapped on an expandable section
        guard sectionInfo.icon != "user_icon",
            sectionInfo.items.count == 0 else {
            return
        }
    }

    func collapsibleTableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer { tableView.deselectRow(at: indexPath, animated: true) }
    }

}

extension MBMenuViewController {

    //MARK: - Class Functions

    func updateName(inSection section: TableSection) {
        if section.icon == "myaccounts_icon",
            numberOfAccounts >= 2 {
            section.name = "Add or remove an account"
        }
    }
    
    func getPageTitleName(_ indexPath: IndexPath) -> String? {
        var pageTitle: String? = nil
        guard let sectionHeader = tableView.headerView(forSection: indexPath.section) as? MBCollapsibleTableViewHeader else { return pageTitle}
        
        switch sectionHeader.titleLabel.text {
        case "Login & Security":
            pageTitle = "Settings"
        case "Contact us", "Help":
            pageTitle = sectionHeader.titleLabel.text
        case "The fine print":
            pageTitle = (tableView.cellForRow(at: indexPath) as? MBMenuTableCell)?.titleLabel.text
        default:
            break
        }
        
        return pageTitle
    }
}


private let kLogoutFooterViewHeight: CGFloat = 10
private let kVersionFooterViewHeight: CGFloat = 20

