//
//  ShimmerEffectView.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 29.03.2024.
//

import SwiftUI

struct ShimmerEffectView: View {
    
    var body: some View {
        VStack {
            ShimmerEffect()
            ShimmerEffect()
            ShimmerEffect()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        .background(.black)
    }
    
    @ViewBuilder
    private func ShimmerEffect() -> some View {
        VStack {
            HStack {
                ShimmerView()
                    .cornerRadius(30)
                    .frame(width: 60, height: 60)
                
                VStack {
                    ShimmerView()
                        .cornerRadius(5)
                        .frame(height: 20)
                    ShimmerView()
                        .cornerRadius(5)
                        .frame(height: 20)
                }
            }
            
            ShimmerView()
                .cornerRadius(5)
                .frame(height: 150)
        }
    }
}

#Preview {
    ShimmerEffectView()
}

struct ShimmerView: View {
    @State private var startPoint: UnitPoint = .init(x: -1.8, y: -1.2)
    @State private var endPoint: UnitPoint = .init(x: 0, y: -0.2)
    
    private var gradientColor = [
        Color.gray.opacity(0.2),
        Color.white.opacity(0.2),
        Color.gray.opacity(0.2)
    ]
    
    var body: some View {
        LinearGradient(colors: gradientColor, startPoint: startPoint, endPoint: endPoint)
            .onAppear {
                withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: false)) {
                    startPoint = .init(x: 1, y: 1)
                    endPoint = .init(x: 2.2, y: 2.2)
                }
            }
    }
}
