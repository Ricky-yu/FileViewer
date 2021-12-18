//
//  Folder.swift
//  FileViewer
//
//  Created by chensinyu on 2021/12/17.
//

import UIKit

class Folder: Item {
    private(set) var contents: [Item] = []
    override weak var store: Store? {
        didSet {
            contents.forEach { $0.store = store }
        }
    }
    
    override init(name: String, url: URL, key: Datakey) {
        contents = []
        super.init(name: name, url: url, key: key)
    }
    func setItem(_ item: Item) {
        assert(contents.contains { $0 === item } == false)
        contents.append(item)
        contents.sort(by: {$0.name.localizedStandardCompare($1.name) == .orderedAscending})
        item.parent = self
    }
    
    func add(_ item: Item) {
        assert(contents.contains { $0 === item } == false)
        contents.append(item)
        contents.sort(by: {$0.name.localizedStandardCompare($1.name) == .orderedAscending})
        let newIndex = contents.index { $0 === item }!
        item.parent = self
        store?.save(item, userInfo: [Item.changeReasonKey: Item.added, Item.newValueKey: newIndex, Item.parentFolderKey: self])
    }
    
    func search() {
        contents = []
        store?.baseURL = self.url
        store?.getData(folder: self)
    }
    
}
