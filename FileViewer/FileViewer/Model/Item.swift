//
//  Item.swift
//  FileViewer
//
//  Created by chensinyu on 2021/12/17.
//

import UIKit
enum Datakey: CodingKey { case folder, txt}
class Item {
    let url: URL
    private(set) var name: String
    private(set) var key: Datakey
    weak var store: Store?
    weak var parent: Folder? {
        didSet {
            store = parent?.store
        }
    }
    
    init(name: String, url: URL, key: Datakey) {
        self.name = name
        self.key = key
        self.url = url
        self.store = nil
    }
    
    func setName(_ newName: String) {
        
    }
    
    func deleted() {
        parent = nil
    }
}

extension Item {
    static let changeReasonKey = "reason"
    static let newValueKey = "newValue"
    static let oldValueKey = "oldValue"
    static let parentFolderKey = "parentFolder"
    static let renamed = "renamed"
    static let added = "added"
    static let removed = "removed"
}
