//
//  ExtensionViewController.swift
//  FileViewer
//
//  Created by chensinyu on 2021/12/18.
//

import UIKit

extension UIViewController {
    func modalTextAlert(title: String, accept: String = .ok, cancel: String = .cancel, placeholder: String, callback: @escaping (String?) -> ()) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addTextField { $0.placeholder = placeholder }
        alert.addAction(UIAlertAction(title: cancel, style: .cancel) { _ in
            callback(nil)
        })
        alert.addAction(UIAlertAction(title: accept, style: .default) { _ in
            callback(alert.textFields?.first?.text)
        })
        present(alert, animated: true)
    }
}

fileprivate extension String {
    static let ok = NSLocalizedString("OK", comment: "")
    static let cancel = NSLocalizedString("Cancel", comment: "")
}
