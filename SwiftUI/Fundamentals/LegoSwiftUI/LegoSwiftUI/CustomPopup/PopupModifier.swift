//
//  PopupModifier.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 13.10.2024.
//

import SwiftUI

/// A reusable popup view modifier with smooth animations.
struct Popup<PopupContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    var backgroundColor: Color = Color.primary.opacity(0.5)
    var animation: Animation = .easeInOut(duration: 0.25)
    var transition: AnyTransition = .opacity.combined(with: .scale(scale: 0.9))
    let popupContent: () -> PopupContent

    func body(content: Content) -> some View {
        ZStack {
            content
                .disabled(isPresented)
            if isPresented {
                backgroundColor
                    .edgesIgnoringSafeArea(.all)
                    .transition(.opacity)
                popupContent()
                    .transition(transition)
                    .zIndex(1)
            }
        }
        .animation(animation, value: isPresented)
    }
}

extension View {
    /// Presents a popup with smooth animations.
    func popup<PopupContent: View>(
        isPresented: Binding<Bool>,
        backgroundColor: Color = Color.primary.opacity(0.5),
        animation: Animation = .easeInOut(duration: 0.25),
        transition: AnyTransition = .opacity.combined(with: .scale(scale: 0.9)),
        @ViewBuilder content: @escaping () -> PopupContent
    ) -> some View {
        self.modifier(Popup(
            isPresented: isPresented,
            backgroundColor: backgroundColor,
            animation: animation,
            transition: transition,
            popupContent: content)
        )
    }
}
