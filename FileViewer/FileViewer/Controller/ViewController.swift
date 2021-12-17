//
//  ViewController.swift
//  FileViewer
//
//  Created by chensinyu on 2021/12/16.
//

import UIKit

class ViewController: UICollectionViewController {
    let fileManager = FileManager.default
    var folderURL: URL = Bundle.main.bundleURL.appendingPathComponent("AFolder")
    private var filesUrl = Array<URL>()
    private var subfilesUrl = Array<URL>()
    var folder: Folder = Store.shared.rootFolder {
        didSet {
            collectionView.reloadData()
            if folder === folder.store?.rootFolder {
                title = "file"
            } else {
                title = folder.name
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print(folderURL)
        if let fileContents = try? fileManager.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: [URLResourceKey.nameKey, URLResourceKey.isDirectoryKey], options: .skipsHiddenFiles) {
            self.filesUrl = fileContents
            print(fileContents)
            subfilesUrl = fileContents.filter { url in
                var isDirectory: ObjCBool = false
                return FileManager.default.fileExists(atPath: url.path, isDirectory: &isDirectory) && isDirectory.boolValue
            }
            print(subfilesUrl)
        } else {
            
        }
    }
}

extension ViewController {
   override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return folder.contents.count // 表示するセルの数
    }
        
   override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FileViewCell", for: indexPath) as! FileViewCell
            let item = folder.contents[indexPath.row]
            cell.setupCell(item: item)
            return cell
        }
}
