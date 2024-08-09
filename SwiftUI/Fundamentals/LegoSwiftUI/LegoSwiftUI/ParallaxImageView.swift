//
//  ParallaxImageView.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 09.08.2024.
//

import SwiftUI

struct ParallaxImageView: View {
    @ObservedObject var motionManager = MotionManager()
    var body: some View {
        ZStack {
            Image("RedSky")
                .offset(x: motionManager.roll * 100, y: motionManager.pitch * 100)
                .onAppear {
                    motionManager.startMonitoringMotionUpdates()
                }
            
            Button {
                print("Hello World")
            } label: {
                Text("Continue")
                    .foregroundStyle(Color.white)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 12).fill(Color.blue))
            }
        }
    }
}

#Preview {
    ParallaxImageView()
}

import CoreMotion

class MotionManager: ObservableObject {
    
    private let motionManager = CMMotionManager()

    @Published var pitch: Double = 0.0
    @Published var roll: Double = 0.0
    
    func startMonitoringMotionUpdates() {
        
        guard self.motionManager.isDeviceMotionAvailable else {
            print("Device motion not available")
            return
        }
        
        self.motionManager.deviceMotionUpdateInterval = 0.01
        
        self.motionManager.startDeviceMotionUpdates(to: .main) { motion, error in
            guard let motion = motion else { return }
            self.pitch = motion.attitude.pitch
            self.roll = motion.attitude.roll
        }
    }
    
    func stopCollectingData() {
        self.motionManager.stopDeviceMotionUpdates()
        self.motionManager.stopGyroUpdates()
    }
    
}
