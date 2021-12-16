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
        return filesUrl.count // 表示するセルの数
        }
        
   override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FileViewCell", for: indexPath) as! FileViewCell
            let item = self.filesUrl[indexPath.row]
            cell.setupCell(title: "\(item)", image: UIImage(named: "folder")!)
            return cell
        }
}
