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
    
    func setupCell(title: String, image: UIImage) {
        self.fileTitle.text = title
        self.fileImageView.image = image
    }
}
