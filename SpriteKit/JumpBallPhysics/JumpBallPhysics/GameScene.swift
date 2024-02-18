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
    
    private let player = SKShapeNode(circleOfRadius: 16)
    private let terrain = SKShapeNode(rectOf: CGSize(width: 500, height: 30))
    
    private var bottomBorder = SKShapeNode()
    private var topBorder = SKShapeNode()
    private var leftBorder = SKShapeNode()
    private var rightBorder = SKShapeNode()
    
    private var startTouch = CGPoint()
    private var endTouch = CGPoint()
    
    override func didMove(to view: SKView) {
        /*Progress bar second screen
        progressBar.getSceneFrame(sceneFrame: frame)
        progressBar.buildProgressBar()
        addChild(progressBar)
        
        var count = 0
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if count > 9 { timer.invalidate() }
            self.progressBar.updateProgressBar()
            count += 1
        }
        End of progress bar second screen*/
        
        backgroundColor = .gray
        
        player.strokeColor = .black
        player.fillColor = .black
        player.physicsBody = SKPhysicsBody(circleOfRadius: 16)
        player.physicsBody?.affectedByGravity = true
        player.physicsBody?.isDynamic = true
        player.position = .init(x: 0, y: 100)
        addChild(player)
        
        buildBorders()
        setCamera()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches { startTouch = touch.location(in: self) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches { endTouch = touch.location(in: self) }
        
        player.physicsBody?.applyImpulse(CGVector(dx: endTouch.x - startTouch.x, dy: endTouch.y - startTouch.y))
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

extension GameScene {
    func buildBorders() {
        terrain.strokeColor = .brown
        terrain.fillColor = .brown
        terrain.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 500, height: 30))
        terrain.physicsBody?.affectedByGravity = false
        terrain.physicsBody?.isDynamic = false
        terrain.position = .init(x: 0, y: -frame.height / 4)
        addChild(terrain)
        
        bottomBorder.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: frame.width, height: 1))
        bottomBorder.physicsBody?.affectedByGravity = false
        bottomBorder.physicsBody?.isDynamic = false
        bottomBorder.position = .init(x: 0, y: -frame.height / 2)
        addChild(bottomBorder)
        
        topBorder.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: frame.width, height: 1))
        topBorder.physicsBody?.affectedByGravity = false
        topBorder.physicsBody?.isDynamic = false
        topBorder.position = .init(x: 0, y: frame.height / 2)
        addChild(topBorder)
        
        leftBorder.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 1, height: frame.height))
        leftBorder.physicsBody?.affectedByGravity = false
        leftBorder.physicsBody?.isDynamic = false
        leftBorder.position = .init(x: -frame.width / 2, y: 0)
        addChild(leftBorder)
        
        rightBorder.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 1, height: frame.height))
        rightBorder.physicsBody?.affectedByGravity = false
        rightBorder.physicsBody?.isDynamic = false
        rightBorder.position = .init(x: frame.width / 2, y: 0)
        addChild(rightBorder)
    }
    
    func setCamera() {
        let camera = SKCameraNode()
        camera.setScale(1)
        addChild(camera)
        scene!.camera = camera
    }
}
