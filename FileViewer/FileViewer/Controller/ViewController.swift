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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FileViewCell", for: indexPath) as! FileViewCell
            let item = folder.contents[indexPath.row]
            cell.setupCell(item: item)
            return cell
        }
}
