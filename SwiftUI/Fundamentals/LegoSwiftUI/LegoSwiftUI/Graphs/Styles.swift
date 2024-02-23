//
//  Styles.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 23.02.2024.
//

import SwiftUI

struct ChartGroupBoxStyle: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.content
            .padding(.top, 30)
            .background(.black)
            .cornerRadius(20)
            .overlay(
                configuration.label.padding(10)
                    .foregroundStyle(.white),
                alignment: .top
            )
    }
}
