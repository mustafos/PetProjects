//
//  ShootShard.swift
//  FirstGame
//
//  Created by Mustafa Bekirov on 16.02.2024.
//

import SpriteKit
import GameplayKit

class ShootShard: SKSpriteNode {
    let shardParticle = SKEmitterNode(fileNamed: "ShootShard")!
    let shardFadeTime: Double = 0.1
    
    let shardRange: CGFloat = 600.0
    let shardSpeed: CGFloat = 600.0
    var shardDuration: CGFloat = 0
    
    var shardEndPoint = CGPoint()
    
    init(startPos: CGPoint, endPos: CGPoint) {
        super.init(texture: SKTexture(), color: .white, size: CGSize(width: 0, height: 0))
        position = startPos
        shardEndPoint = endPos
        
        let x = endPos.x - position.x
        let y = endPos.y - position.y
        
        let distance = sqrt(x * x + y * y)
        
        shardDuration = distance / shardSpeed
        
        addShardParticle()
        addShardActions()
    }
    
    func addShardParticle() {
        shardParticle.targetNode = self
        shardParticle.emissionAngle = CGFloat(-atan2(shardEndPoint.x - position.x,
                                                     shardEndPoint.y - position.y) - .pi/2)
        addChild(shardParticle)
    }
    
    func addShardActions() {
        let shardMove = SKAction.move(to: shardEndPoint, duration: shardDuration)
        let shardFade = SKAction.fadeOut(withDuration: shardFadeTime)
        
        let shardSound = SKAction.playSoundFileNamed("plasma", waitForCompletion: false)
        
        run(SKAction.sequence([shardSound, shardMove, shardFade, .removeFromParent()]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
