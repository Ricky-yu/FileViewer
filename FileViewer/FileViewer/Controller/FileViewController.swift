//
//  FileViewController.swift
//  FileViewer
//
//  Created by chensinyu on 2021/12/19.
//

import UIKit

class FileViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    var file: File? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = file?.name
        do{
            textView.text = try String(contentsOf: file!.url, encoding: .utf8)
        }catch{
            print("No file")
        }
    }
}
