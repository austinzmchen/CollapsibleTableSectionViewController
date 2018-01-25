//
//  CollapsibleTableView+Info.swift
//  ACKit
//
//  Created by Austin Chen on 2018-01-24.
//

import Foundation

public class Item: NSObject {
    public var name: String
    public var detail: String
    public var url: String?
    
    public init(name: String, detail: String, url: String?) {
        self.name = name
        self.detail = detail
        self.url = url
    }
}

public class Section: NSObject {
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
