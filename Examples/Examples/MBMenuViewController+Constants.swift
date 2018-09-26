//
//  MBMenuViewController+Constants.swift
//  MBNA
//
//  Created by Austin Chen on 2018-01-17.
//  Copyright © 2018 Austin Chen. All rights reserved.
//

import Foundation
import CollapsibleTableSectionViewController

extension MBMenuViewController {
    static let loggedOutRows:[SideMenuRowDescriptor] = [
        SideMenuRowDescriptor(title: "About", imageName: "icon-about", url: ""),
    ]

    static  let loggedInRows:[SideMenuRowDescriptor] = [
        SideMenuRowDescriptor(title: "Add another account", imageName: "myaccounts_icon", url:nil),
        SideMenuRowDescriptor(title: "My Profile", imageName: "icon-profile", url: nil),
        SideMenuRowDescriptor(title: "Statement Methods", imageName: "icon-statement", url: nil),
        SideMenuRowDescriptor(title: "Help", imageName: "icon-help", url: nil)
    ]

    static let loggedOutSectionInfos: [TableSection] = [
        TableSection(name: "Contact us", icon: "contact_icon", url: nil, items: []),
        TableSection(name: "The fine print", icon: "legal_icon", url: nil, items: [
            TableItem(name: "Privacy", detail: "", url: nil),
            TableItem(name: "Security statement", detail: "", url: nil),
            TableItem(name: "Terms of use", detail: "", url: nil),
            TableItem(name: "Legal", detail: "", url: nil)
            ])
    ]

    static let loggedInSectionInfos: [TableSection] = [
        TableSection(name: "George Robert Stephanopoulos".uppercased(), icon: "user_icon", url: nil, items: []),
        TableSection(name: "Login & Security", icon: "login_security_icon", url: nil,items: [
            TableItem(name: "Change password", detail: "", url: nil),
            TableItem(name: "Change login name", detail: "", url: nil),
            TableItem(name: "Update challenge questions", detail: "", url: nil),
            ]),
        TableSection(name: "Add another account", icon: "myaccounts_icon", url: nil, items: []),
        //        Section(name: "StatementDeliveryPreferences", icon: "myaccounts_icon", url: nil, items: []),
        TableSection(name: "Contact us", icon: "contact_icon", url: nil, items: []),
        TableSection(name: "Help", icon: "help_icon", url: nil, items: []),
        TableSection(name: "The fine print", icon: "legal_icon", url: nil, items: [
            TableItem(name: "Glossary of terms", detail: "", url: nil),
            TableItem(name: "Privacy", detail: "", url: nil),
            TableItem(name: "Security statement", detail: "", url: nil),
            TableItem(name: "Terms of use", detail: "", url: nil),
            TableItem(name: "Legal", detail: "", url: nil),
            TableItem(name: "Electronic access agreement", detail: "", url: nil)
            ])
    ]
}
