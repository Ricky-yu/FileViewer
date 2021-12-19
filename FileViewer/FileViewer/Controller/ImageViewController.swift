//
//  ImageViewController.swift
//  FileViewer
//
//  Created by chensinyu on 2021/12/19.
//

import UIKit

class ImageViewController: UIViewController {
    @IBOutlet weak var ImageView: UIImageView!
    var image: Image? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        title = image?.name
        do {
            let imageData = try Data(contentsOf: image!.url)
            ImageView.image =  UIImage(data: imageData)
        } catch {
            print("No image")
        }
    }
    
}
