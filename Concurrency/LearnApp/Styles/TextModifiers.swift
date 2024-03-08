//
//  TextModifiers.swift
//  LearnApp
//
//  Created by Mustafa Bekirov on 23.03.2023.
//

import SwiftUI

struct SectionTitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.footnote.weight(.semibold))
            .foregroundColor(.secondary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(20)
    }
}

extension View {
    func sectionTitleModifier() -> some View {
        modifier(SectionTitleModifier())
    }
}
