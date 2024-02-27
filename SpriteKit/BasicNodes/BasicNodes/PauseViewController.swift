//
//  PauseViewController.swift
//  BasicNodes
//
//  Created by Mustafa Bekirov on 25.02.2024.
//

import UIKit

protocol PauseVCDeledate {
    func pauseVCPlayButton(_ viewController: PauseViewController)
    func pauseVCSoundButton(_ viewController: PauseViewController)
    func pauseVCMusicButton(_ viewController: PauseViewController)
}

class PauseViewController: UIViewController {
    
    var soundButton: UIButton!
    var musicButton: UIButton!
    var delegate: PauseVCDeledate!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func playButtonPress(_ sender: Any) {
        delegate.pauseVCPlayButton(self)
    }
    
    @IBAction func storeButtonPress(_ sender: Any) {
    }
    
    @IBAction func menuButtonPress(_ sender: Any) {
    }
    
    @IBAction func settingsButtonPress(_ sender: Any) {
        let alert = UIAlertController(title: "Settings", message: "Choose an option", preferredStyle: .alert)
        
        // Create a custom view controller to host the buttons and labels
        let settingsViewController = UIViewController()
        
        // The sound setting
        let soundLabel = UILabel(frame: CGRect(x: 20, y: 5, width: 200, height: 30))
        soundLabel.text = "Sound"
        settingsViewController.view.addSubview(soundLabel)
        
        soundButton = UIButton(type: .system)
        soundButton.frame = CGRect(x: 220, y: 5, width: 30, height: 30)
        soundButton.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        soundButton.tintColor = .green
        soundButton.addTarget(self, action: #selector(soundButtonPressed(_:)), for: .touchUpInside)
        settingsViewController.view.addSubview(soundButton)
        
        let divider = UIView(frame: CGRect(x: 0, y: 45, width: 300, height: 1))
        divider.backgroundColor = UIColor.lightGray
        settingsViewController.view.addSubview(divider)
        
        // The music setting
        let musicLabel = UILabel(frame: CGRect(x: 20, y: 55, width: 200, height: 30))
        musicLabel.text = "Music"
        settingsViewController.view.addSubview(musicLabel)
        
        musicButton = UIButton(type: .system)
        musicButton.frame = CGRect(x: 220, y: 55, width: 30, height: 30)
        musicButton.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        musicButton.tintColor = .green
        musicButton.addTarget(self, action: #selector(musicButtonPressed(_:)), for: .touchUpInside)
        settingsViewController.view.addSubview(musicButton)
        
        alert.setValue(settingsViewController, forKey: "contentViewController")
        
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { (_) in
            // Handle Done button action if needed
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func soundButtonPressed(_ sender: UIButton) {
        delegate.pauseVCSoundButton(self)
    }
    
    @objc func musicButtonPressed(_ sender: UIButton) {
        delegate.pauseVCMusicButton(self)
    }
}
