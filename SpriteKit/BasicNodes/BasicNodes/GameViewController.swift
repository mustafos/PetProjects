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

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    
    @IBAction func pauseButtonPress(_ sender: UIButton) {
        pauseButton.setImage(UIImage(named: gameScene.gameIsPaused ? "pause" : "play"), for: .normal)
        gameScene.pauseButtonPressed(sender: sender)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
