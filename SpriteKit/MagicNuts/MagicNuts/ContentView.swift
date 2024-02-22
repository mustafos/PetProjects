//
//  ContentView.swift
//  MagicNuts
//
//  Created by Mustafa Bekirov on 20.02.2024.
//

//import SwiftUI
//import SpriteKit
//
//struct ContentView: View {
//    var scene: SKScene {
//        let scene = GameScene()
//        scene.size = CGSize(width: 300, height: 400)
//        scene.scaleMode = .fill
//        return scene
//    }
//    
//    var body: some View {
//        SpriteView(scene: scene)
//            .frame(width: 300, height: 400)
//            .ignoresSafeArea()
//    }
//}
//
//#Preview {
//    ContentView()
//}
//
//class GameScene: SKScene {
//    override func didMove(to view: SKView) {
//        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
//    }
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let touch = touches.first else { return }
//        let location = touch.location(in: self)
//        let box = SKSpriteNode(imageNamed: "nut")
//        box.position = location
//        box.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 41, height: 50))
//        addChild(box)
//    }
//}

import SwiftUI
import SpriteKit
import WebKit

struct GameView: View {
    @State private var gameOver = false
    @State private var gameWon = false
    @State private var gameStarted = false
    @State private var gameTime = 0
    @State private var gameTimer: Timer?
    @State private var ballSpeed: CGFloat = 0
    @State private var ballPosition: CGPoint = CGPoint(x: 0, y: 0)
    @State private var ballDirection: CGFloat = 0
    @State private var gameURL: String = ""
    
    var body: some View {
        ZStack {
            if gameOver {
                WebView(url: gameURL)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .edgesIgnoringSafeArea(.all)
            } else {
                GameSceneView(gameStarted: $gameStarted, ballSpeed: $ballSpeed, ballPosition: $ballPosition, ballDirection: $ballDirection, gameTime: $gameTime, gameOver: $gameOver, gameWon: $gameWon)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .edgesIgnoringSafeArea(.all)
                    .onAppear {
                        gameURL = getGameURL()
                    }
                    .overlay(
                        Button(action: {
                            gameStarted.toggle()
                            if gameStarted {
                                gameTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                                    gameTime += 1
                                    if gameTime >= 30 {
                                        gameWon = true
                                        gameOver = true
                                    }
                                }
                            } else {
                                gameTimer?.invalidate()
                                gameTime = 0
                            }
                        }) {
                            Text(gameStarted ? "Stop" : "Start")
                                .font(.largeTitle)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                            .padding()
                    )
            }
        }
    }
    
    func getGameURL() -> String {
        let url = "https://2llctw8ia5.execute-api.us-west-1.amazonaws.com/prod"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let response = try? JSONDecoder().decode(GameResponse.self, from: data) {
                    gameURL = gameWon ? response.winnerURL : response.loserURL
                }
            }
        }
        task.resume()
        return gameURL
    }
}

struct GameResponse: Codable {
    let winnerURL: String
    let loserURL: String
}

struct GameSceneView: UIViewRepresentable {
    @Binding var gameStarted: Bool
    @Binding var ballSpeed: CGFloat
    @Binding var ballPosition: CGPoint
    @Binding var ballDirection: CGFloat
    @Binding var gameTime: Int
    @Binding var gameOver: Bool
    @Binding var gameWon: Bool
    
    func makeUIView(context: Context) -> SKView {
        let view = SKView()
        let scene = GameScene(gameStarted: $gameStarted, ballSpeed: $ballSpeed, ballPosition: $ballPosition, ballDirection: $ballDirection, gameTime: $gameTime, gameOver: $gameOver, gameWon: $gameWon)
        view.presentScene(scene)
        return view
    }
    
    func updateUIView(_ uiView: SKView, context: Context) {
    }
}

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    @Binding var gameStarted: Bool
    @Binding var ballSpeed: CGFloat
    @Binding var ballPosition: CGPoint
    @Binding var ballDirection: CGFloat
    @Binding var gameTime: Int
    @Binding var gameOver: Bool
    @Binding var gameWon: Bool
    
    var ball: SKSpriteNode!
    var platforms: [SKSpriteNode] = []
    var obstacles: [SKSpriteNode] = []
    var platformSpeed: CGFloat = -25
    var lastPlatform: SKSpriteNode?
    
    init(gameStarted: Binding<Bool>, ballSpeed: Binding<CGFloat>, ballPosition: Binding<CGPoint>, ballDirection: Binding<CGFloat>, gameTime: Binding<Int>, gameOver: Binding<Bool>, gameWon: Binding<Bool>) {
        _gameStarted = gameStarted
        _ballSpeed = ballSpeed
        _ballPosition = ballPosition
        _ballDirection = ballDirection
        _gameTime = gameTime
        _gameOver = gameOver
        _gameWon = gameWon
        
        super.init(size: CGSize(width: 375, height: 812))
        
        self.physicsWorld.contactDelegate = self
        
        setupBall()
        setupPlatforms()
        setupObstacles()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupBall() {
        ball = SKSpriteNode(color: .red, size: CGSize(width: 30, height: 30))
        ball.position = CGPoint(x: 100, y: 400)
        ball.physicsBody = SKPhysicsBody(circleOfRadius: 15)
        ball.physicsBody?.isDynamic = true
        ball.physicsBody?.allowsRotation = false
        ball.physicsBody?.friction = 0
        ball.physicsBody?.restitution = 1
        ball.physicsBody?.categoryBitMask = 1
        ball.physicsBody?.contactTestBitMask = 2
        ball.physicsBody?.collisionBitMask = 0
        self.addChild(ball)
    }
    
    func setupPlatforms() {
        for i in 0..<5 {
            let platform = SKSpriteNode(color: .green, size: CGSize(width: 375, height: 50))
            platform.position = CGPoint(x: 0, y: CGFloat(i * 100) - 200)
            platform.physicsBody = SKPhysicsBody(rectangleOf: platform.size)
            platform.physicsBody?.isDynamic = false
            platform.physicsBody?.categoryBitMask = 2
            platform.physicsBody?.contactTestBitMask = 1
            platform.physicsBody?.collisionBitMask = 0
            platforms.append(platform)
            self.addChild(platform)
        }
        lastPlatform = platforms.last
    }
    
    func setupObstacles() {
        for i in 0..<5 {
            let obstacle = SKSpriteNode(color: .blue, size: CGSize(width: 50, height: 50))
            obstacle.position = CGPoint(x: CGFloat(i * 100) + 100, y: 200)
            obstacle.physicsBody = SKPhysicsBody(rectangleOf: obstacle.size)
            obstacle.physicsBody?.isDynamic = false
            obstacle.physicsBody?.categoryBitMask = 4
            obstacle.physicsBody?.contactTestBitMask = 1
            obstacle.physicsBody?.collisionBitMask = 0
            obstacles.append(obstacle)
            self.addChild(obstacle)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        if gameStarted {
            ball.physicsBody?.velocity = CGVector(dx: ballSpeed * cos(ballDirection), dy: ballSpeed * sin(ballDirection))
            ballPosition = ball.position
            ballDirection = atan2(ball.physicsBody!.velocity.dy, ball.physicsBody!.velocity.dx)
            
            for platform in platforms {
                platform.position.y -= platformSpeed
                if platform.position.y < -platform.size.height {
                    platform.position.y = lastPlatform!.position.y + lastPlatform!.size.height
                }
            }
            
            for obstacle in obstacles {
                obstacle.position.y -= platformSpeed
                if obstacle.position.y < -obstacle.size.height {
                    obstacle.position.y = lastPlatform!.position.y + lastPlatform!.size.height
                }
            }
            
            if ball.position.y < -ball.size.height {
                gameOver = true
            }
            
            if ball.physicsBody!.velocity.dy > 0 && ball.position.y > self.frame.height / 2 {
                if gameTime < 30 {
                    gameOver = true
                } else {
                    gameWon = true
                }
            }
            
            if gameOver {
                ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            }
        }
    }
}

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.load(URLRequest(url: URL(string: url)!))
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
}
