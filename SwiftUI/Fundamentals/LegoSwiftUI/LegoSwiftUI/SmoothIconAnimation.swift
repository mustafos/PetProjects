//
//  SmoothIconTransition.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 06.03.2024.
//

import SwiftUI

struct SmoothIconAnimation: View {
    @State private var isRotation: Bool = false
    @State private var isHidden: Bool = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 15) {
                Line()
                    .rotationEffect(.degrees(isRotation ? 48 : 0), anchor: .leading)
                
                Line()
                    .scaleEffect(isHidden ? 0 : 1, anchor: isHidden ? .trailing : .leading)
                    .opacity(isHidden ? 0 : 1)
                
                Line()
                    .rotationEffect(.degrees(isRotation ? -48 : 0), anchor: .leading)
            }
            .onTapGesture {
                withAnimation(.interpolatingSpring(stiffness: 500, damping: 15)) {
                    isRotation.toggle()
                    isHidden.toggle()
                }
            }
        }
    }
    
    @ViewBuilder
    func Line() -> some View {
        Rectangle()
            .frame(width: 65, height: 10)
            .cornerRadius(5)
    }
}

#Preview {
    SmoothIconAnimation()
}
