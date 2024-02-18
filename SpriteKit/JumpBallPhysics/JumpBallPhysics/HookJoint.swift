//
//  HookJoint.swift
//  JumpBallPhysics
//
//  Created by Mustafa Bekirov on 17.02.2024.
//

import SpriteKit

class HookJoint: SKSpriteNode {
    
    init() {
        let texture = SKTexture(imageNamed: "player")
        
        super.init(texture: texture, color: .white, size: texture.size())
        
        name = "hookjoint"
        position = CGPoint(x: 0, y: 0)
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        zPosition = 0
        
        self.physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
//        physicsBody?.categoryBitMask = CollisionType.hookjoint.rawValue
//        physicsBody?.collisionBitMask = CollisionType.player.rawValue | CollisionType.raycast.rawValue
//        physicsBody?.contactTestBitMask = CollisionType.player.rawValue | CollisionType.raycast.rawValue
        physicsBody?.isDynamic = false
        physicsBody?.affectedByGravity = false
        physicsBody?.allowsRotation = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
