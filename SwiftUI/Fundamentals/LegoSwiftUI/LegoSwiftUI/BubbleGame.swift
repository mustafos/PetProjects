//
//  BubbleGame.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 16.02.2024.
//

import SwiftUI
import CoreMotion
import WebKit

struct BubbleGame: View {
    @StateObject private var viewModel = GameViewModel()
    @State private var showingWebView = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                
                if viewModel.gameOver {
                    Button(action: {
                        viewModel.restartGame()
                    }) {
                        Text("Restart")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                } else {
                    // Draw ball
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 50, height: 50)
                        .position(viewModel.ballPosition)
                    
                    // Draw platforms
                    ForEach(viewModel.platforms, id: \.id) { platform in
                        Rectangle()
                            .fill(Color.green)
                            .frame(width: platform.width, height: 20)
                            .position(platform.position)
                    }
                    
                    // Start button
                    if !viewModel.gameStarted {
                        Button(action: {
                            viewModel.startGame()
                        }) {
                            Text("Start")
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                }
            }
            .onAppear {
                viewModel.setupMotionManager()
                viewModel.loadURLs()
            }
            .onChange(of: viewModel.gameOver) { newValue in
                if newValue {
                    showingWebView = true
                }
            }
            .sheet(isPresented: $showingWebView) {
                WebView(urlString: viewModel.gameOver ? viewModel.loserURL : viewModel.winnerURL)
            }
        }
    }
}

struct WebView: View {
    let urlString: String
    
    var body: some View {
        WebViewRepresentable(urlString: urlString)
    }
}

struct GameView: View {
    var body: some View {
        BubbleGame()
    }
}

#Preview {
    GameView()
}

class GameViewModel: ObservableObject {
    @Published var ballPosition: CGPoint = .zero
    @Published var platforms: [Platform] = []
    @Published var gameStarted: Bool = false
    @Published var gameOver: Bool = false
    @Published var winnerURL: String = ""
    @Published var loserURL: String = ""
    
    private var motionManager = CMMotionManager()
    private let platformSpeed: CGFloat = 25
    private let platformWidthRange: ClosedRange<CGFloat> = 100...200
    private var timer: Timer?
    
    func setupMotionManager() {
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.1
            motionManager.startAccelerometerUpdates(to: .main) { [weak self] data, _ in
                if let acceleration = data?.acceleration {
                    self?.updateBallPosition(with: acceleration)
                }
            }
        }
    }
    
    func updateBallPosition(with acceleration: CMAcceleration) {
        ballPosition.x -= CGFloat(acceleration.x) * 50
    }
    
    func startGame() {
        gameStarted = true
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.spawnPlatform()
        }
    }
    
    func restartGame() {
        ballPosition = .zero
        platforms = []
        gameStarted = false
        gameOver = false
        loadURLs()
    }
    
    func spawnPlatform() {
        let platformWidth = CGFloat.random(in: platformWidthRange)
        let platformPosition = CGPoint(x: CGFloat.random(in: 0...(UIScreen.main.bounds.width - platformWidth)), y: 0)
        platforms.append(Platform(id: UUID(), position: platformPosition, width: platformWidth))
    }
    
    func loadURLs() {
        guard let url = URL(string: "https://2llctw8ia5.execute-api.us-west-1.amazonaws.com/prod") else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let urls = try JSONDecoder().decode(URLs.self, from: data)
                DispatchQueue.main.async {
                    self?.winnerURL = urls.winner
                    self?.loserURL = urls.loser
                }
            } catch {
                print("Error decoding URLs: \(error)")
            }
        }.resume()
    }
}

struct Platform: Identifiable {
    var id: UUID
    var position: CGPoint
    var width: CGFloat
}

struct WebViewRepresentable: UIViewRepresentable {
    let urlString: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {}
}

struct URLs: Codable {
    let winner: String
    let loser: String
}
