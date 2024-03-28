//
//  BlureView.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 28.03.2024.
//

import SwiftUI

struct BlureView: View {
    @State private var isBlur: Bool = false
    var body: some View {
        VStack {
            Text("Lego \nLego App")
                .font(.system(size: 80))
                .bold()
                .foregroundStyle(.yellow)
                .onTapGesture {
                    self.isBlur.toggle()
                }
        }
        .modifier(BlureModifier(showBlure: $isBlur, content: {
            VStack(spacing: 10) {
                Color.black.opacity(0.1)
            }
            .ignoresSafeArea()
            .onTapGesture {
                isBlur.toggle()
            }
        }))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
    }
}

#Preview {
    BlureView()
}

struct BlureModifier<BlureContent: View>: ViewModifier {
    @Binding var showBlure: Bool
    @State private var blureRadius: CGFloat = 10
    
    let content: () -> BlureContent
    
    func body(content: Content) -> some View {
        Group {
            content
                .blur(radius: showBlure ? blureRadius : 0)
                .animation(.easeInOut, value: showBlure)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay {
            self.content()
                .opacity(showBlure ? 1 : 0)
                .animation(.easeInOut(duration: 0.4), value: showBlure)
        }
    }
}
