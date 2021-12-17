//
//  Store.swift
//  FileViewer
//
//  Created by chensinyu on 2021/12/17.
//

import UIKit

final class Store {
    let fileManager = FileManager.default
    static let changedNotification = Notification.Name("StoreChanged")
    static private let folderURL: URL = Bundle.main.bundleURL.appendingPathComponent(.storeLocation)
    
    static let shared = Store(url: folderURL)
    
    let baseURL: URL?
    var placeholder: URL?
    let rootFolder = Folder(name: "AFolder", url: folderURL, key: .folder)
    
    init(url: URL?) {

        self.baseURL = url
        self.placeholder = nil
        print(url)
        if let fileContents = try? fileManager.contentsOfDirectory(at: url!, includingPropertiesForKeys: [URLResourceKey.nameKey, URLResourceKey.isDirectoryKey], options: .skipsHiddenFiles) {
            //self.filesUrl = fileContents
            print(fileContents)
//            subfilesUrl = fileContents.filter { url in
//                var isDirectory: ObjCBool = false
//                return FileManager.default.fileExists(atPath: url.path, isDirectory: &isDirectory) && isDirectory.boolValue
//            }
        } else {
            
        }
        self.rootFolder = Folder(name: "", uuid: UUID())
        self.rootFolder.store = self
    }
    
    func save(_ notifying: Item, userInfo: [AnyHashable: Any]) {
        if let url = baseURL, let data = try? JSONEncoder().encode(rootFolder) {
            try! data.write(to: url.appendingPathComponent(.storeLocation))

        }
        NotificationCenter.default.post(name: Store.changedNotification, object: notifying, userInfo: userInfo)
    }
    
    func item(atUUIDPath path: [UUID]) -> Item? {
        return rootFolder.item(atUUIDPath: path[0...])
    }
    
}

fileprivate extension String {
    static let storeLocation = "AFolder"
}

