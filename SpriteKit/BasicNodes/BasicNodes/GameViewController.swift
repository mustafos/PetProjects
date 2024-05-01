//
//  GameViewController.swift
//  BasicNodes
//
//  Created by Mustafa Bekirov on 25.02.2024.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var pauseButton: UIButton!
    
    private var gameScene: GameScene!
    private var pauseViewController: PauseViewController!
    private var gameOverViewController: GameOverViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pauseViewController = storyboard?.instantiateViewController(withIdentifier: "pauseViewController") as? PauseViewController
        
        gameOverViewController = storyboard?.instantiateViewController(withIdentifier: "gameOverViewController") as? GameOverViewController
        
        pauseViewController.delegate = self
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                gameScene = (scene as! GameScene)
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func showPauseScreen(_ viewController: UIViewController) {
        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.view.frame = view.bounds
        
        viewController.view.alpha = 0
        
        UIView.animate(withDuration: 0.5) {
            viewController.view.alpha = 1
        }
    }
    
    func hidePauseScreen(viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.removeFromParent()
        
        viewController.view.alpha = 1
        
        UIView.animate(withDuration: 0.5) {
            viewController.view.alpha = 0
        } completion: { completion in
            viewController.view.removeFromSuperview()
        }

    }
    
    @IBAction func pauseButtonPress(_ sender: UIButton) {
        gameScene.pauseTheGame()
        showPauseScreen(pauseViewController)
        //present(pauseViewController, animated: true, completion: nil) /*Full Screen View*/
    }
}

extension GameViewController: PauseVCDeledate {
    func pauseVCPlayButton(_ viewController: PauseViewController) {
        hidePauseScreen(viewController: pauseViewController)
        gameScene.unpauseTheGame()
    }
    
    func pauseVCSoundButton(_ viewController: PauseViewController) {
        print("Change sound")
    }
    
    func pauseVCMusicButton(_ viewController: PauseViewController) {
        gameScene.musicOn = !gameScene.musicOn
        gameScene.isMusicOn()
        
        let musicImage = gameScene.musicOn ? UIImage(systemName: "checkmark.circle") : UIImage(systemName: "xmark.circle")
        let musicColor = gameScene.musicOn ? UIColor.green : UIColor.red
    
        viewController.musicButton.setImage(musicImage, for: .normal)
        viewController.musicButton.tintColor = musicColor
    }
}
