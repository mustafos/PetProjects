//
//  ViewController.swift
//  SwiftAPI
//
//  Created by Mustafa Bekirov on 30.01.2023.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIManager.shared.getPosts { posts in
            //do something whith posts
        }
        
        APIManager.shared.getPhotos { photos in
            //do something whith photos
        }
    }
}


