//
//  FloatingButtonView.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 29.03.2024.
//

import SwiftUI

struct FloatingButtonView: View {
    var body: some View {
        ZStack {
            AssistiveFloatingButton {
                print("OK")
            }
        }
        .background(.black)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
    }
}

#Preview {
    FloatingButtonView()
}

struct AssistiveFloatingButton: View {
    @State private var dragAmount: CGPoint?
    @State private var opacityState: Double = 1
    var action: () -> Void
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                Spacer()
                VStack {
                    Spacer()
                    Circle()
                        .frame(width: 50, height: 50)
                        .foregroundStyle(.yellow)
                        .shadow(radius: 3)
                        .overlay {
                            Image(systemName: "message.badge.filled.fill")
                                .resizable()
                                .frame(width: 25, height: 25)
                        }
                        .opacity(opacityState)
                        .onTapGesture {
                            action()
                            withAnimation(.linear(duration: 0.1)) {
                                opacityState = 0.2
                            }
                            withAnimation(.linear(duration: 0.1).delay(0.1)) {
                                opacityState = 1
                            }
                        }
                        .position(dragAmount ?? CGPoint(x: geometry.size.width-34, y: geometry.size.height-100))
                        .gesture(
                            DragGesture()
                                .onChanged { self.dragAmount = $0.location }
                                .onEnded { value in
                                    var currentPosition = value.location
                                    if currentPosition.x > (geometry.size.width / 2) {
                                        currentPosition.x = geometry.size.width-34
                                    } else {
                                        currentPosition.x = 16
                                    }
                                    
                                    withAnimation(.interpolatingSpring(mass: 1.0, stiffness: 100.0, damping: 10, initialVelocity: 0)) {
                                        dragAmount = currentPosition
                                    }
                                }
                        )
                }
            }
        }
    }
}
