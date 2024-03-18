//
//  RingProgressBarView.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 17.03.2024.
//  #colorLiteral(red: 0.5, green: 0.8, blue: 0.6, alpha: 1)

import SwiftUI

struct RingProgressBarView: View {
    
    @Binding var animateTheRings: Bool
    
    @Binding var progressValueOne: CGFloat
    @Binding var progressValueTwo: CGFloat
    @Binding var progressValueThree: CGFloat
    
    let strawberry = Color(#colorLiteral(red: 0.9612273574, green: 0.07646275312, blue: 0.3081150651, alpha: 1))
    let lime = Color(#colorLiteral(red: 0.6066545248, green: 0.9980902076, blue: 0.00786343962, alpha: 1))
    let ice = Color(#colorLiteral(red: 0, green: 0.851926744, blue: 0.9892144799, alpha: 1))
    
    let animation = Animation.easeOut(duration: 3)
    
    var body: some View {
        ZStack {
            Color.black
            ring(for: strawberry, progress: progressValueOne)
                .frame(width: 165)
            ring(for: lime, progress: progressValueTwo)
                .frame(width: 128)
            ring(for: ice, progress: progressValueThree)
                .frame(width: 92)
        }
        .animation(animation, value: animateTheRings)
        .ignoresSafeArea()
    }
    
    @ViewBuilder
    private func ring(for color: Color, progress value: CGFloat) -> some View {
        Circle()
            .stroke(style: StrokeStyle(lineWidth: 16))
            .foregroundStyle(.tertiary)
            .overlay {
                Circle()
                    .trim(from: 0, to: value)
                    .stroke(color.gradient, style: StrokeStyle(lineWidth: 16, lineCap: .round))
            }
            .rotationEffect(.degrees(-90))
    }
}
