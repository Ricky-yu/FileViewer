//
//  FileViewCell.swift
//  FileViewer
//
//  Created by chensinyu on 2021/12/16.
//

import UIKit

class FolderViewCell: UICollectionViewCell {
    
    @IBOutlet weak var folderImageView: UIImageView!
    
    @IBOutlet weak var folderTitle: UILabel!
    
    func setupCell(item: Item) {
        self.folderTitle.text = item.name
        switch item.key {
        case .folder:
            self.folderImageView.image = UIImage(named: "folder")
        default:
            self.folderImageView.image = UIImage(named: "folder")
        }
        
    }
}
