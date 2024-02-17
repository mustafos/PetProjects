//
//  GameScene.swift
//  SandBox
//
//  Created by Mustafa Bekirov on 16.02.2024.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
//    private var progressBar = ProgressBar()
    
    let player = Player()
    let hookJoint = HookJoint()
    
    var spring = SKPhysicsJointSpring()
    var limit = SKPhysicsJointLimit()
    var slide = SKPhysicsJointSliding()
    var pin = SKPhysicsJointPin()
    var fixed = SKPhysicsJointFixed()
    
    let terrain = SKShapeNode(rectOf: CGSize(width: 500, height: 30))
    let bottomBorder = SKShapeNode()
    let topBorder = SKShapeNode()
    let leftBorder = SKShapeNode()
    let rightBorder = SKShapeNode()
    
    var selectedJoint = JointType.spring
    
//    private var startTouch = CGPoint()
//    private var endTouch = CGPoint()
    
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
        
        physicsWorld.contactDelegate = self
        
        addChild(player)
        addChild(hookJoint)
        hookJoint.position = CGPoint(x: 0, y: 500)
        
        setCamera()
        buildBorders()
    }
    
    func leftTouchDown(atPoint pos: CGPoint) {
        switch selectedJoint {
        case .spring:
            spring = SKPhysicsJointSpring.joint(withBodyA: hookJoint.physicsBody!, bodyB: player.physicsBody!, anchorA: hookJoint.position, anchorB: player.position)
            spring.damping = 1
            spring.frequency = 100
            physicsWorld.add(spring)
        case .limit:
            limit = SKPhysicsJointLimit.joint(withBodyA: hookJoint.physicsBody!, bodyB: player.physicsBody!, anchorA: hookJoint.position, anchorB: player.position)
            limit.maxLength = 300
            physicsWorld.add(limit)
        case .slide:
            slide = SKPhysicsJointSliding.joint(withBodyA: hookJoint.physicsBody!, bodyB: player.physicsBody!, anchor: hookJoint.position, axis: CGVector(dx: 100, dy: 0))
            slide.shouldEnableLimits = false
            slide.lowerDistanceLimit = -100
            slide.upperDistanceLimit = 100
            physicsWorld.add(slide)
        case .pin:
            pin = SKPhysicsJointPin.joint(withBodyA: hookJoint.physicsBody!, bodyB: player.physicsBody!, anchor: hookJoint.position)
            physicsWorld.add(pin)
        case .fixed:
            fixed = SKPhysicsJointFixed.joint(withBodyA: hookJoint.physicsBody!, bodyB: player.physicsBody!, anchor: hookJoint.position)
            physicsWorld.add(fixed)
        }
    }
    
    func leftTouchMoved(toPoint pos: CGPoint) {
        
    }
    
    func leftTouchUp(atPoint pos: CGPoint) {
        switch selectedJoint {
        case .spring:
            physicsWorld.remove(spring)
        case .limit:
            physicsWorld.remove(limit)
        case .slide:
            physicsWorld.remove(slide)
        case .pin:
            physicsWorld.remove(pin)
        case .fixed:
            physicsWorld.remove(fixed)
        }
    }
    
    override func mouseDown(with event: NSEvent) {
        self.leftTouchDown(atPoint: event.location(in: self))
    }
    
    override func mouseDragged(with event: NSEvent) {
        self.leftTouchMoved(toPoint: event.location(in: self))
    }
    
    override func mouseUp(with event: NSEvent) {
        self.leftTouchUp(atPoint: event.location(in: self))
    }
    
    func rightTouchDown(atPoint pos: CGPoint) {
        let hookNode = HookJoint()
        hookNode.position = pos
        addChild(hookNode)
    }
    
    override func rightMouseDown(with event: NSEvent) {
        self.rightTouchDown(atPoint: event.location(in: self))
    }
    
    override func keyDown(with event: NSEvent) {
        switch event.keyCode {
        case 0:
            player.physicsBody?.velocity = CGVector(dx: -player.moveSpeed,
                                                    dy: player.physicsBody!.velocity.dy)
        case 2:
            player.physicsBody?.velocity = CGVector(dx: player.moveSpeed,
                                                    dy: player.physicsBody!.velocity.dy)
        case 18:
            selectedJoint = .spring
        case 19:
            selectedJoint = .limit
        case 20:
            selectedJoint = .slide
        case 21:
            selectedJoint = .pin
        case 23:
            selectedJoint = .fixed
        case 49:
            player.physicsBody?.velocity = CGVector(dx: player.physicsBody!.velocity.dx, dy: player.jumpSpeed)
        case 0x31:
            print("this key was pressed \(event.characters!) keyCode: \(event.keyCode)")
        default:
            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

extension GameScene {
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        
        let sortedNodes = [nodeA, nodeB].sorted { $0.name ?? "" < $1.name ?? "" }
        
        let firstNode = sortedNodes[0]
        let secondNode = sortedNodes[1]
        
        print("contact between \(firstNode.name) and \(secondNode.name)")
        
        if secondNode.name == "player", let hook = firstNode as? HookJoint {
            print("contact: \(hook)")
        }
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
        leftBorder.position = .init(x: -frame.height / 2, y: 0)
        addChild(leftBorder)
        
        rightBorder.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 1, height: frame.height))
        rightBorder.physicsBody?.affectedByGravity = false
        rightBorder.physicsBody?.isDynamic = false
        rightBorder.position = .init(x: frame.height / 2, y: 0)
        addChild(rightBorder)
    }
    
    func setCamera() {
        let camera = SKCameraNode()
        camera.setScale(1)
        addChild(camera)
        scene?.camera = camera
    }
}

enum JointType {
    case spring
    case limit
    case slide
    case pin
    case fixed
}
