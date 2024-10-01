//
//  ConfirmationDialogView.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 13.10.2024.
//

import SwiftUI

struct ConfirmationDialogView: View {
    @Binding var show: Bool
    var title: String
    var message: String
    var confirmAction: () -> Void

    var body: some View {
        VStack(spacing: 25) {
            Image(systemName: "trash.fill")
                .font(.system(size: 60))
                .foregroundColor(.white)
                .padding()
                .background(Circle().fill(Color.red))
                .shadow(radius: 10)

            Text(title)
                .font(.title2)
                .fontWeight(.bold)

            Text(message)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.horizontal)

            HStack(spacing: 20) {
                Button(action: {
                    show = false
                }) {
                    Text("Cancel")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray)
                        .cornerRadius(15)
                }

                Button(action: {
                    confirmAction()
                    show = false
                }) {
                    Text("Delete")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(15)
                }
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

