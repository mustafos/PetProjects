//
//  AlertView.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 13.10.2024.
//

import SwiftUI

/// A reusable alert view component.
struct AlertView: View {
    @Binding var show: Bool
    var icon: String
    var iconColor: Color
    var title: String
    var message: String
    var buttonText: String
    var buttonColor: Color

    var body: some View {
        VStack(spacing: 25) {
            Image(systemName: icon)
                .font(.system(size: 60))
                .foregroundColor(.white)
                .padding()
                .background(Circle().fill(iconColor))
                .shadow(radius: 10)

            Text(title)
                .font(.title2)
                .fontWeight(.bold)

            Text(message)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.horizontal)

            Button(action: {
                show = false
            }) {
                Text(buttonText)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(buttonColor)
                    .cornerRadius(15)
            }
            .padding(.horizontal)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color(UIColor.systemBackground))
                .shadow(radius: 10)
        )
        .padding()
    }
}
