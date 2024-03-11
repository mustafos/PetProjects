//
//  AnimateSFSymbolsView.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 11.03.2024.
//

import SwiftUI

struct AnimateSFSymbolsView: View {
    var body: some View {
        VStack {
            Text("Discrete Animation")
            DiscreteAnimation()
            Spacer()
            Text("Idefinite Animation")
            IdefiniteAnimation()
            Spacer()
            Text("Transition Animation")
            TransitionAnimation()
            Spacer()
            Text("Content Transition Animation")
            ContentTransitionAnimation()
        }
        .padding()
    }
    
    /// Discrete Animation
    @State private var animationCount = 0
    
    @ViewBuilder
    private func DiscreteAnimation() -> some View {
        VStack {
            Image(systemName: "wifi.router")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .symbolEffect(.bounce, value: animationCount)
                .frame(width: 100, height: 100)
            
            Button("Animate") {
                animationCount += 1
            }
        }
    }
    
    /// Idefinite Animation
    @State private var animationIsActive = false
    private var idefinitebuttonTitle: String {
        return animationIsActive ? "Stop" : "Start"
    }
    
    @ViewBuilder
    private func IdefiniteAnimation() -> some View {
        VStack {
            Image(systemName: "wifi.router")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .symbolEffect(.pulse, isActive: animationIsActive)
                .frame(width: 100, height: 100)
            
            Button(idefinitebuttonTitle) {
                animationIsActive.toggle()
            }
        }
    }
    
    /// Transition Animation
    @State private var symbolsHidden = false
    private var transitionbuttonTitle: String {
        return symbolsHidden ? "Show" : "Hide"
    }
    
    @ViewBuilder
    private func TransitionAnimation() -> some View {
        VStack {
            if !symbolsHidden {
                Image(systemName: "wifi.router")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .transition(.symbolEffect(.appear))
            }
            
            Button(transitionbuttonTitle) {
                symbolsHidden.toggle()
            }
        }
    }
    
    /// Content Transition Animation
    @State private var muteOn: Bool = false
    private var title: String {
        return muteOn ? "Unmute" : "Mute"
    }
    
    @ViewBuilder
    private func ContentTransitionAnimation() -> some View {
        VStack {
            Button {
                muteOn.toggle()
            } label: {
                Label(title, systemImage: !muteOn ? "sneaker.wave.3.fill" : "speaker.slash.fill")
            }
            .contentTransition(.symbolEffect(.replace))
        }
    }
}

#Preview {
    AnimateSFSymbolsView()
}
