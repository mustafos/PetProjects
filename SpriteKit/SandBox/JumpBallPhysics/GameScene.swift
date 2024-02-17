//
//  GameScene.swift
//  SandBox
//
//  Created by Mustafa Bekirov on 16.02.2024.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var progressBar = ProgressBar()
    
    override func didMove(to view: SKView) {
        progressBar.getSceneFrame(sceneFrame: frame)
        progressBar.buildProgressBar()
        addChild(progressBar)
        
        var count = 0
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if count > 9 { timer.invalidate() }
            self.progressBar.updateProgressBar()
            count += 1
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
