//
//  ProgressBar.swift
//  JumpBallPhysics
//
//  Created by Mustafa Bekirov on 17.02.2024.
//

import SpriteKit

class ProgressBar: SKNode {
    private var progress = CGFloat(0)
    private var maxProgress = CGFloat(9)
    private var maxProgressBarWidth = CGFloat(0)
    
    private var progressBar = SKSpriteNode()
    private var progressBarContainer = SKSpriteNode()
    
    private let progressTexture = SKTexture(imageNamed: "progBar")
    private let progressContainerTexture = SKTexture(imageNamed: "progCon")
    
    private var sceneFrame = CGRect()
    
    override init() {
        super.init()
    }
    
    func getSceneFrame(sceneFrame: CGRect) {
        self.sceneFrame = sceneFrame
        maxProgressBarWidth = sceneFrame.width * 0.65
    }
    func buildProgressBar() {
        progressBarContainer = SKSpriteNode(texture: progressContainerTexture,
                                            size: progressContainerTexture.size())
        progressBarContainer.size.width = sceneFrame.width * 0.7
        progressBarContainer.size.height = sceneFrame.height * 0.1
        
        progressBar = SKSpriteNode(texture: progressTexture,
                                            size: progressTexture.size())
        progressBar.size.width = 0
        progressBar.size.height = sceneFrame.height * 0.08
        progressBar.position.x = -maxProgressBarWidth / 2.0
        progressBar.anchorPoint = CGPoint(x: 0, y: 0.5)
        
        addChild(progressBar)
        addChild(progressBarContainer)
    }
    
    func updateProgressBar() {
        if progress > maxProgress { return }
        
        progressBar.run(SKAction.resize(toWidth: CGFloat(progress / maxProgress) * maxProgressBarWidth, duration: 0.2))
        
        progress += 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

