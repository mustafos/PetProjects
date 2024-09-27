//
//  LaunchView.swift
//  WebViewApp
//
//  Created by Mustafa Bekirov on 11.09.2024.
//

import SwiftUI

struct LaunchView: View {
    @State private var ballOffset: CGFloat = -100
    
    var body: some View {
        VStack {
            Circle()
                .fill(Color.blue)
                .frame(width: 50, height: 50)
                .offset(y: ballOffset)
                .onAppear {
                    withAnimation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true)) {
                        ballOffset = 100
                    }
                }
        }
    }
}
