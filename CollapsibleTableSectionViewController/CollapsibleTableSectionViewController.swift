//
//  CollapsibleTableSectionViewController.swift
//  CollapsibleTableSectionViewController
//
//  Created by Yong Su on 7/20/17.
//  Copyright © 2017 jeantimex. All rights reserved.
//

import UIKit

open class CollapsibleTableSectionViewController: UIViewController {
    
    public var tableView: CollapsibleTableView!
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        // Create the tableView
        tableView = CollapsibleTableView()
        
        // Auto layout the tableView
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: topLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}
