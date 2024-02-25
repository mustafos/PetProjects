//
//  GameScene.swift
//  BasicNodes
//
//  Created by Mustafa Bekirov on 25.02.2024.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    // 1. Create node
    private var spaceShip: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        scene?.size = UIScreen.main.bounds.size
        
        // size
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        
        let spaceBackground = SKSpriteNode(imageNamed: "space")
        spaceBackground.size = CGSize(width: width, height: height)
        addChild(spaceBackground)
        
        // 2. init node
        spaceShip = SKSpriteNode(imageNamed: "spaceShip")
        spaceShip.xScale = 0.5
        spaceShip.yScale = 0.5
        spaceShip.physicsBody = SKPhysicsBody(texture: spaceShip.texture!, size: spaceShip.size)
        spaceShip.physicsBody?.isDynamic = false
        addChild(spaceShip)
        
        // generation asteroid
        let asteroidCreate = SKAction.run {
            let asteroid = self.createAsteroid()
            self.addChild(asteroid)
        }
        let asteroidPerSecond: Double = 20
        let asteroidCreationDelay = SKAction.wait(forDuration: 1.0 / asteroidPerSecond, withRange: 0.5)
        let asteroidSequenceAction = SKAction.sequence([asteroidCreate, asteroidCreationDelay])
        let asteroidRunAction = SKAction.repeatForever(asteroidSequenceAction)
        
        run(asteroidRunAction)
    }
    
    // C = sqrt((x2 - x1)2 + (y2 - y1)2)
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            // 3. Determine the point of contact
            let touchLocation = touch.location(in: self)
            
            // 4. Create Action
            let distance = distanceCalculate(a: spaceShip.position, b: touchLocation)
            let speed: CGFloat = 500
            let time = timeToTravelDistance(distance: distance, speed: speed)
            let moveAction = SKAction.move(to: touchLocation, duration: time)
            print("time: \(time)")
            print("distance: \(distance)")
            
            spaceShip.run(moveAction)
        }
    }
    
    func distanceCalculate(a: CGPoint, b: CGPoint) -> CGFloat {
        return sqrt((b.x - a.x) * (b.x - a.x) + (b.y - a.y) * (b.y - a.y))
    }
    
    func timeToTravelDistance(distance: CGFloat, speed: CGFloat) -> TimeInterval {
        let time = distance / speed
        return TimeInterval(time)
    }
    
    func createAsteroid() -> SKSpriteNode {
        let asteroid = SKSpriteNode(imageNamed: "asteroid")
        
        let randomScale = CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound: 6)) / 10
        
        asteroid.xScale = randomScale
        asteroid.yScale = randomScale
        asteroid.position.x = CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound: 6))
        asteroid.position.y = frame.size.height + asteroid.size.height
        
        asteroid.physicsBody = SKPhysicsBody(texture: asteroid.texture!, size: asteroid.size)
        
        return asteroid
    }
    
    override func update(_ currentTime: TimeInterval) {
//        let asteroid = createAsteroid()
//        addChild(asteroid)
    }
}
