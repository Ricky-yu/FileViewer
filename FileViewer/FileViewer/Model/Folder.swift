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
    
    func add(_ item: Item) {
        contents.append(item)
        contents.sort(by: {$0.name.localizedStandardCompare($1.name) == .orderedAscending})
    }
    
}
