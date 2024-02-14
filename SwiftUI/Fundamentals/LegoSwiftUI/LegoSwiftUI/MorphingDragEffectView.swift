//
//  MorphingDragEffectView.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 14.02.2024.
//

import SwiftUI

struct MorphingDragEffectView<RenderShape: Shape>: View {
    @ViewBuilder var shape: RenderShape
    @State private var dragValue: CGSize = .zero
    
    var body: some View {
        ZStack {
            VStack {
                DragView()
            }
        }
        .background(.gray)
        .ignoresSafeArea()
    }
    
    @ViewBuilder
    func BlobShape(offset: CGSize = .zero) -> some View {
        shape.fill(.green)
            .frame(width: 150, height: 150)
            .offset(offset)
    }
    
    @ViewBuilder
    func DragView() -> some View {
        Rectangle()
            .fill(.linearGradient(colors: [.green, .white], startPoint: .top, endPoint: .bottom))
            .mask({
                Canvas { context, size in
                    context.addFilter(.alphaThreshold(min: 0.5, color: .red))
                    context.addFilter(.blur(radius: 30))
                    context.drawLayer { ctx in
                        // Selecting 1 and 2 we will have two shapes
                        for index in [1, 2] {
                            if let resolvedView = context.resolveSymbol(id: index) {
                                ctx.draw(resolvedView, at: CGPoint(x: size.width / 2, y: size.height / 2))
                            }
                        }
                    }
                } symbols: {
                    BlobShape().tag(1)
                    BlobShape(offset: dragValue).tag(2)
                }
            })
            .gesture(
                DragGesture().onChanged({ value in
                    dragValue = value.translation
                }).onEnded({ _ in
                    withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                        dragValue = .zero
                    }
                })
            )
    }
}

#Preview {
    MorphingDragEffectView {
        Rectangle()
    }
}
