//
//  ExtensionString.swift
//  FileViewer
//
//  Created by chensinyu on 2021/12/18.
//

import UIKit

extension String {
    static let ok = NSLocalizedString("OK", comment: "")
    static let cancel = NSLocalizedString("Cancel", comment: "")
    static let uuidPathKey = "uuidPath"
    static let showRecorder = "showRecorder"
    static let showPlayer = "showPlayer"
    static let showFolder = "showFolder"
    
    static let recordings = NSLocalizedString("Recordings", comment: "Heading for the list of recorded audio items and folders.")
    static let createFolder = NSLocalizedString("Create Folder", comment: "Header for folder creation dialog")
    static let folderName = NSLocalizedString("Folder Name", comment: "Placeholder for text field where folder name should be entered.")
    static let create = NSLocalizedString("Create", comment: "Confirm button for folder creation dialog")
}
