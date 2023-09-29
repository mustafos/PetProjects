//
//  SuperScrollView.swift
//  QuizAll
//
//  Created by Mustafa Bekirov on 29.09.2023.
//

import SwiftUI

struct SuperScrollView: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(MockData.item) { item in
                    Circle()
                        .containerRelativeFrame(.horizontal,
                                                count: verticalSizeClass == .regular ? 2 : 4,
                                                spacing: 16)
                        .foregroundStyle(item.color.gradient)
                        .scrollTransition { content, phase in
                            content
                                .opacity(phase.isIdentity ? 1.0 : 0.0)
                                .scaleEffect(x: phase.isIdentity ? 1.0 : 0.3,
                                             y: phase.isIdentity ? 1.0 : 0.3)
                                .offset(y: phase.isIdentity ? 0 : 50)
                            
                        }
                }
            }
            .scrollTargetLayout()
        }
        .contentMargins(16, for: .scrollContent)
        .scrollTargetBehavior(.viewAligned)
    }
}

#Preview {
    SuperScrollView()
}

struct Item: Identifiable {
    let id = UUID()
    let color: Color
}

struct MockData {
    static var item = [Item(color: .teal),
                       Item(color: .pink),
                       Item(color: .indigo),
                       Item(color: .orange),
                       Item(color: .purple),
                       Item(color: .yellow),
                       Item(color: .green),
                       Item(color: .brown),
                       Item(color: .red)]
}
