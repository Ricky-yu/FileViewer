//
//  ViewController.swift
//  FileViewer
//
//  Created by chensinyu on 2021/12/16.
//

import UIKit

class ViewController: UICollectionViewController {
    @IBOutlet weak var navifationBar: UINavigationItem!
    private var folder: Folder = Store.shared.rootFolder {
        didSet {
            collectionView.reloadData()
            if folder === folder.store?.rootFolder {
                navifationBar.title = "no Name"
            } else {
                navifationBar.title = folder.name
            }
        }
    }
    
    @objc func handleChangeNotification(_ notification: Notification) {
        collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        folder.search()
        NotificationCenter.default.addObserver(self, selector: #selector(handleChangeNotification(_:)), name: Store.changedNotification, object: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        if identifier == .showFolder {
            let folderVC = segue.destination as! ViewController
            let cell = sender as! UICollectionViewCell
            let indexPath = self.collectionView!.indexPath(for: cell)
            let selectedFolder = folder.contents[indexPath!.row] as! Folder
            folderVC.folder = selectedFolder
        } else if identifier == .showFile {
            let fileVC = segue.destination as! FileViewController
            let cell = sender as! UICollectionViewCell
            let indexPath = self.collectionView!.indexPath(for: cell)
            let selectedFile = folder.contents[indexPath!.row] as! File
            fileVC.file = selectedFile
        } else {
            let imageVC = segue.destination as! ImageViewController
            let cell = sender as! UICollectionViewCell
            let indexPath = self.collectionView!.indexPath(for: cell)
            let selectedImage = folder.contents[indexPath!.row] as! Image
            imageVC.image = selectedImage
        }
    }
    
    
    @IBAction func createNewFolder(_ sender: Any) {
        modalTextAlert(title: .createFolder, accept: .create, placeholder: .folderName) { string in
            if let s = string {
                let encodeUrlString: String = s.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                let urlString = self.folder.url.absoluteString + encodeUrlString
                let newFolder = Folder(name: s, url: URL(string: urlString)!, key: .folder)
                self.folder.add(newFolder)
            }
            self.dismiss(animated: true)
        }
    }
}

extension ViewController {
   override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return folder.contents.count // 表示するセルの数
    }
        
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = folder.contents[indexPath.row]
        var identifier:String?
        print(item.name)
        print(item.key)
        switch item.key {
        case .folder: identifier = "FolderViewCell"
        case .txt: identifier = "FileViewCell"
        default:
            identifier = "ImageViewCell"
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier!, for: indexPath)
        switch cell {
        case is FolderViewCell:
            (cell as! FolderViewCell).setupCell(item: item)
        case is FileViewCell:
            (cell as! FileViewCell).setupCell(item: item)
        default:
            (cell as! ImageViewCell).setupCell(item: item)
        }
        
        return cell
    }
}
