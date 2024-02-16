//
//  ViewController.swift
//  Facade
//
//  Created by Mustafa Bekirov on 19.02.2023.
//

import UIKit

enum ImageSaveError: Error {
    case couldNotCreateDestinationPath
    case couldNotCreateJPEGDataFromImage
    case couldNotCreatePNGDataFromImage
    case couldNotSaveImageDestinationPath
}

enum ImageType {
    case png
    case jpeg(compressionQuality: CGFloat)
}

class ViewController: UIViewController {
    let imageSaver = ImageSaverFacade()
    let image = UIImage(named: "picture")!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            try imageSaver.save(image: image, type: .png, fileName: "my_file_name", overwrite: true)
        } catch {
            print(error)
        }
    }
}

