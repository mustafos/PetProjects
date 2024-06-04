//
//  ViewController.swift
//  RemoteConfig
//
//  Created by Mustafa Bekirov on 04.06.2024.
//

import UIKit
import FirebaseRemoteConfig

class ViewController: UIViewController {
    
    var remoteConfig = RemoteConfig.remoteConfig()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.contentMode = .scaleAspectFill
        
        startButton.layer.cornerRadius = 12
        startButton.clipsToBounds = true
        startButton.tintColor = .white
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        remoteConfig.fetchAndActivate { status, error in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                if status != .error {
                    if let stringURL = self.remoteConfig["bg_image_1"].stringValue {
                        DispatchQueue.main.async {
                            self.imageView.load(stringURL: stringURL)
                        }
                    }
                    if let backgroundColor = self.remoteConfig["bg_button"].stringValue {
                        let cicolor = CIColor(string: backgroundColor)
                        let uicolor = UIColor(ciColor: cicolor)
                        self.startButton.backgroundColor = uicolor
                    }
                }
            }
        }
    }
}

extension UIImageView {
    func load(stringURL: String) {
        if let url = URL(string: stringURL) {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            }
        }
    }
}
