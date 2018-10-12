//
//  CollapsibleTableViewDataDelegate.swift
//  ACKit
//
//  Created by Austin Chen on 2018-01-24.
//

import Foundation

open class CollapsibleTableViewDataDelegate: NSObject, UITableViewDataSource, UITableViewDelegate {
    public unowned var tView: CollapsibleTableView
    
    public init(fromTableView tView: CollapsibleTableView) {
        self.tView = tView
        
        super.init()
    }
    
    open func numberOfSections(in tableView: UITableView) -> Int {
        return tView.clpDelegate?.numberOfSections(tView) ?? 1
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows = tView.clpDelegate?.collapsibleTableView(tView, sectionInfoAt: section)?.items.count ?? 0
        return tView.isSectionCollapsed(section) ? 0 : numberOfRows
    }
    
    // Cell
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tView.clpDelegate?.collapsibleTableView(tView, cellForRowAt: indexPath) ?? UITableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "DefaultCell")
    }
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tView.clpDelegate?.collapsibleTableView(tView, heightForRowAt: indexPath) ?? UITableViewAutomaticDimension
    }
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tView.clpDelegate?.collapsibleTableView(tView, didSelectRowAt: indexPath)
    }
    
    // Header
    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = (tView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CollapsibleTableViewHeader) ?? CollapsibleTableViewHeader(reuseIdentifier: "header")
        
        let title = tView.clpDelegate?.collapsibleTableView(tView, sectionInfoAt: section)?.name ?? ""
        
        header.titleLabel.text = title
        header.arrowLabel.text = ">"
        header.setCollapsed(tView.isSectionCollapsed(section))
        
        header.section = section
        
        return header
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tView.clpDelegate?.collapsibleTableView(tView, heightForHeaderInSection: section) ?? 44.0
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return tView.clpDelegate?.collapsibleTableView(tView, heightForFooterInSection: section) ?? 0.0
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
