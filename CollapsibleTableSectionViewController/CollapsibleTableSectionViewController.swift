//
//  CollapsibleTableSectionViewController.swift
//  CollapsibleTableSectionViewController
//
//  Created by Yong Su on 7/20/17.
//  Copyright © 2017 jeantimex. All rights reserved.
//

import UIKit

public struct Item {
    public var name: String
    public var detail: String
    public var url: String?
    
    public init(name: String, detail: String, url: String?) {
        self.name = name
        self.detail = detail
        self.url = url
    }
}

public struct Section {
    public var name: String
    public var icon: String
    public var url: String?
    public var items: [Item]
    
    public init(name: String, icon: String, url: String?, items: [Item]) {
        self.name = name
        self.icon = icon
        self.url = url
        self.items = items
    }
}

//
// MARK: - CollapsibleTableSectionDelegate
//
public protocol CollapsibleTableSectionDelegate {
    func numberOfSections(_ tableView: UITableView) -> Int
    func collapsibleTableView(_ tableView: UITableView, sectionInfoAt section: Int) -> Section
    
    // cell
    func collapsibleTableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    func collapsibleTableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    // header/footer
    func collapsibleTableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    func collapsibleTableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    
    //  actions
    func collapsibleTableView(_ tableView: UITableView, didSelectSectionHeaderAt section: Int)
    func collapsibleTableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    func shouldCollapseByDefault(_ tableView: UITableView, section: Int) -> Bool
    func shouldCollapseOthers(_ tableView: UITableView) -> Bool
}

//
// MARK: - View Controller
//
open class CollapsibleTableSectionViewController: UIViewController, CollapsibleTableViewHeaderDelegate {
    
    public var delegate: CollapsibleTableSectionDelegate?
    
    // TODO: ac
//    fileprivate var _tableView: UITableView!
    public var _tableView: UITableView!
    
    fileprivate var _sectionsState = [Int : Bool]()
    
    public func isSectionCollapsed(_ section: Int) -> Bool {
//         turn off to allow asking each time.
        if _sectionsState.index(forKey: section) == nil {
            _sectionsState[section] = delegate?.shouldCollapseByDefault(_tableView, section: section) ?? false
        }
        
//        _sectionsState[section] = delegate?.shouldCollapseByDefault(_tableView, section: section) ?? false
        return _sectionsState[section]!
    }
    
    open func reloadSections() {
        _sectionsState = [:]
        _tableView.reloadData()
    }
    
    open func getSectionsNeedReload(_ section: Int) -> [Int] {
        var sectionsNeedReload = [section]
        
        // Toggle collapse
        let isCollapsed = !isSectionCollapsed(section)
        
        // Update the sections state
        _sectionsState[section] = isCollapsed
        
        let shouldCollapseOthers = delegate?.shouldCollapseOthers(_tableView) ?? false
        
        if !isCollapsed && shouldCollapseOthers {
            // Find out which sections need to be collapsed
            let filteredSections = _sectionsState.filter { !$0.value && $0.key != section }
            let sectionsNeedCollapse = filteredSections.map { $0.key }
            
            // Mark those sections as collapsed in the state
            for item in sectionsNeedCollapse { _sectionsState[item] = true }
            
            // Update the sections that need to be redrawn
            sectionsNeedReload.append(contentsOf: sectionsNeedCollapse)
        }
        
        return sectionsNeedReload
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        // Create the tableView
        _tableView = UITableView()
        _tableView.dataSource = self
        _tableView.delegate = self
        
        // Auto resizing the height of the cell
        _tableView.estimatedRowHeight = 44.0
        _tableView.rowHeight = UITableViewAutomaticDimension
        
        // Auto layout the tableView
        view.addSubview(_tableView)
        _tableView.translatesAutoresizingMaskIntoConstraints = false
        _tableView.topAnchor.constraint(equalTo: topLayoutGuide.topAnchor).isActive = true
        _tableView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.bottomAnchor).isActive = true
        _tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        _tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    // Delegate method
    open func toggleSection(_ section: Int) {
        let sectionsNeedReload = getSectionsNeedReload(section)
        _tableView.reloadSections(IndexSet(sectionsNeedReload), with: .automatic)
    }
}

//
// MARK: - View Controller DataSource and Delegate
//
extension CollapsibleTableSectionViewController: UITableViewDataSource, UITableViewDelegate {
    
    open func numberOfSections(in tableView: UITableView) -> Int {
        return delegate?.numberOfSections(tableView) ?? 1
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows = delegate?.collapsibleTableView(tableView, sectionInfoAt: section).items.count ?? 0
        return isSectionCollapsed(section) ? 0 : numberOfRows
    }
    
    // Cell
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return delegate?.collapsibleTableView(tableView, cellForRowAt: indexPath) ?? UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "DefaultCell")
    }
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return delegate?.collapsibleTableView(tableView, heightForRowAt: indexPath) ?? UITableViewAutomaticDimension
    }
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.collapsibleTableView(tableView, didSelectRowAt: indexPath)
    }
    
    // Header
    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: "header")
        
        let title = delegate?.collapsibleTableView(tableView, sectionInfoAt: section).name ?? ""
        
        header.titleLabel.text = title
        header.arrowLabel.text = ">"
        header.setCollapsed(isSectionCollapsed(section))
        
        header.section = section
        //        header.delegate = self // TODO: ac
        
        return header
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return delegate?.collapsibleTableView(tableView, heightForHeaderInSection: section) ?? 44.0
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return delegate?.collapsibleTableView(tableView, heightForFooterInSection: section) ?? 0.0
    }
}

//
// MARK: - Section Header Delegate
//

/* move to class so it can be overridden
extension CollapsibleTableSectionViewController: CollapsibleTableViewHeaderDelegate {
    public func toggleSection(_ section: Int) {
        let sectionsNeedReload = getSectionsNeedReload(section)
        _tableView.reloadSections(IndexSet(sectionsNeedReload), with: .automatic)
    }
}
 */
