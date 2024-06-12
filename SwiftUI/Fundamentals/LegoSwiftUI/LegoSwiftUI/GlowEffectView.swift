//
//  GlowEffectView.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 11.06.2024.
//

import SwiftUI

struct GlowEffectView: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("I")
                    .font(.custom("MadimiOne-Regular", size: 100))
                    .foregroundStyle(.white)
                    .glow()
                
                Image(systemName: "heart.fill")
                    .foregroundColor(.red)
                    .font(.system(size: 100))
                    .glow()
                
                Image(systemName: "apple.logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                    .foregroundStyle(.white)
                    .glow()
            }
        }
    }
}

#Preview {
    GlowEffectView()
}

struct Glow: ViewModifier {
    @State private var throb: Bool = false
    func body(content: Content) -> some View {
        ZStack {
            content
                .blur(radius: throb ? 20 : 5)
                .animation(.easeOut(duration: 0.5).repeatForever(), value: throb)
                .onAppear {
                    throb.toggle()
                }
                .overlay {
                    content
                    .blur(radius: throb ? 50 : 20)
                    .animation(.easeOut(duration: 0.5).repeatForever(), value: throb)
                    .overlay {
                        content
                        .blur(radius: throb ? 70 : 50)
                        .animation(.easeOut(duration: 0.5).repeatForever(), value: throb)
                        .overlay {
                            content
                            .blur(radius: throb ? 100 : 70)
                            .animation(.easeOut(duration: 0.5).repeatForever(), value: throb)
                        }
                    }
                }
            content
                .overlay {
                    content
                    .blur(radius: throb ? 10 : 5)
                    .animation(.easeOut(duration: 0.5).repeatForever(), value: throb)
                    .overlay {
                        content
                        .blur(radius: throb ? 100 : 50)
                        .animation(.easeOut(duration: 0.5).repeatForever(), value: throb)
                    }
                }
        }
    }
}

extension View {
    func glow() -> some View {
        modifier(Glow())
    }
}
