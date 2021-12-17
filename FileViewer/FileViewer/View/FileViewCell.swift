//
//  FileViewCell.swift
//  FileViewer
//
//  Created by chensinyu on 2021/12/16.
//

import UIKit

class FileViewCell: UICollectionViewCell {
    
    @IBOutlet weak var fileImageView: UIImageView!
    @IBOutlet weak var fileTitle: UILabel!
    
    func setupCell(item: Item) {
        self.fileTitle.text = item.name
        switch item.key {
        case .folder:
            self.fileImageView.image = UIImage(named: "folder")
        case .txt:
            self.fileImageView.image = UIImage(named: "file")
        default:
            self.fileImageView.image = UIImage(named: "file")
        }
        
    }
}
