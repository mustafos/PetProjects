//
//  Player.swift
//  JumpBallPhysics
//
//  Created by Mustafa Bekirov on 17.02.2024.
//

import SpriteKit

class Player: SKSpriteNode {
    let moveSpeed = CGFloat(1500)
    let jumpSpeed = CGFloat(2000)
    
    init() {
        let texture = SKTexture(imageNamed: "PlayerBall")
        
        super.init(texture: texture, color: .white, size: texture.size())
        
        name = "player"
        position = CGPoint(x: 0, y: 0)
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        zPosition = 1
        
        self.physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
//        physicsBody?.categoryBitMask = CollisionType.player.rawValue
//        physicsBody?.collisionBitMask = CollisionType.hookjoint.rawValue | CollisionType.rayhead.rawValue
//        physicsBody?.contactTestBitMask = CollisionType.hookjoint.rawValue | CollisionType.rayhead.rawValue
        physicsBody?.isDynamic = true
        physicsBody?.affectedByGravity = true
        physicsBody?.allowsRotation = true
        physicsBody?.restitution = 0.2
        physicsBody?.friction = 0.2
        physicsBody?.angularDamping = 0.2
        physicsBody?.linearDamping = 0.2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
