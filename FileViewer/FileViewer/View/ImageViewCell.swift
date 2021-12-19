//
//  ImageViewCell.swift
//  FileViewer
//
//  Created by chensinyu on 2021/12/19.
//

import UIKit

class ImageViewCell: UICollectionViewCell {
   
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var ImageTitle: UILabel!
    
    func setupCell(item: Item) {
        self.ImageTitle.text = item.name
        switch item.key {
        case .png:
            self.ImageView.image = UIImage(named: "PNGImage")
        default:
            self.ImageView.image = UIImage(named: "PNGImage")
        }
        
    }
    
}
