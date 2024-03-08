//
//  TypewriterTextAnimation.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 06.03.2024.
//

import SwiftUI

struct TypewriterTextAnimation: View {
    
    let text:  String
    var delay: CGFloat = 75
    var font: Font
    var textAlignment: TextAlignment = .leading
    
    @State private var animatedText = ""
    
    var body: some View {
        VStack {
            Text(animatedText)
                .multilineTextAlignment(.center)
                .font(font)
                .padding()
                .task {
                    await animate()
                }
        }
    }
    
    private func animate() async {
        for char in text {
            animatedText.append(char)
            try! await Task.sleep(for: .milliseconds(delay))
        }
    }
}

#Preview {
    TypewriterTextAnimation(text: "Demo Text View", font: .body)
}
