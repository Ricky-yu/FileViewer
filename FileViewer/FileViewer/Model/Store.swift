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
    static private let folderURL: URL = Bundle.main.bundleURL.appendingPathComponent("AFolder")
    static let shared = Store(url: folderURL)
    let baseURL: URL?
    var placeholder: URL?
    let rootFolder = Folder(name: "AFolder", url: folderURL, key: .folder)
    
    init(url: URL?) {
        self.baseURL = url
        self.placeholder = nil
        if let fileContents = try? fileManager.contentsOfDirectory(at: url!, includingPropertiesForKeys: [URLResourceKey.nameKey, URLResourceKey.isDirectoryKey], options: .skipsHiddenFiles) {
            
            for (i, url) in fileContents.enumerated() {
                let fileName = url.absoluteString.split(separator: "/").last!
                var isDirectory:ObjCBool = false
                let isExist = fileManager.fileExists(atPath: url.path, isDirectory: &isDirectory)
                if isExist && isDirectory.boolValue {
                    rootFolder.add(Item(name: "\(fileName.removingPercentEncoding!)", url: url, key: .folder))
                } else {
                    rootFolder.add(Item(name: "\(fileName.removingPercentEncoding!)", url: url, key: .txt))
                }
            }
        }
            self.rootFolder.store = self
    }
    
    func getData(folder: Folder) {
        if let fileContents = try? fileManager.contentsOfDirectory(at: self.baseURL!, includingPropertiesForKeys: [URLResourceKey.nameKey, URLResourceKey.isDirectoryKey], options: .skipsHiddenFiles) {
            
            for (i, url) in fileContents.enumerated() {
                let fileName = url.absoluteString.split(separator: "/").last!
                var isDirectory:ObjCBool = false
                let isExist = fileManager.fileExists(atPath: url.path, isDirectory: &isDirectory)
                if isExist && isDirectory.boolValue {
                    folder.setItem(Folder(name: "\(fileName.removingPercentEncoding!)", url: url, key: .folder))
                } else {
                    print("\(fileName.removingPercentEncoding!)")
                    folder.setItem(Folder(name: "\(fileName.removingPercentEncoding!)", url: url, key: .txt))
                }
            }
        }
        NotificationCenter.default.post(name: Store.changedNotification, object: nil, userInfo: nil)
    }
    
    func save(_ notifying: Item, userInfo: [AnyHashable: Any]) {
        NotificationCenter.default.post(name: Store.changedNotification, object: notifying, userInfo: userInfo)
    }
}
