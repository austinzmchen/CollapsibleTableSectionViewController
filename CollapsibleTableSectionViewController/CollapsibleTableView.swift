//
//  CollapsibleTableView.swift
//  ACKit
//
//  Created by Austin Chen on 2018-01-24.
//

import UIKit

//
// MARK: - CollapsibleTableSectionDelegate
//
public protocol CollapsibleTableSectionDelegate: class {
    func numberOfSections(_ tableView: UITableView) -> Int
    func collapsibleTableView(_ tableView: UITableView, sectionInfoAt section: Int) -> TableSection?
    
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

open class CollapsibleTableView: UITableView {
    
    open weak var clpDelegate: CollapsibleTableSectionDelegate?
    open var dataDelegate: CollapsibleTableViewDataDelegate?
    
    fileprivate var _sectionsState = [Int : Bool]()
    
    public func isSectionCollapsed(_ section: Int) -> Bool {
        if _sectionsState.index(forKey: section) == nil {
            _sectionsState[section] = clpDelegate?.shouldCollapseByDefault(self, section: section) ?? false
        }
        return _sectionsState[section]!
    }
    
    open func reloadSections() {
        _sectionsState = [:]
        reloadData()
    }
    
    open func getSectionsNeedReload(_ section: Int) -> [Int] {
        var sectionsNeedReload = [section]
        
        // Toggle collapse
        let isCollapsed = !isSectionCollapsed(section)
        
        // Update the sections state
        _sectionsState[section] = isCollapsed
        
        let shouldCollapseOthers = clpDelegate?.shouldCollapseOthers(self) ?? false
        
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
    
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        dataDelegate = CollapsibleTableViewDataDelegate(fromTableView: self)
        delegate = dataDelegate
        dataSource = dataDelegate
        
        // Auto resizing the height of the cell
        estimatedRowHeight = 44.0
        rowHeight = UITableViewAutomaticDimension
    }
    
    // Delegate method
    open func toggleSection(_ section: Int) {
        let sectionsNeedReload = getSectionsNeedReload(section)
        reloadSections(IndexSet(sectionsNeedReload), with: .automatic)
    }
}
