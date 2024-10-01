//
//  PasswordPromptView.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 13.10.2024.
//

import SwiftUI

struct PasswordPromptView: View {
    @Binding var show: Bool
    var onUnlock: (String) -> Void
    @State private var password: String = ""

    var body: some View {
        VStack(spacing: 25) {
            Image(systemName: "lock.fill")
                .font(.system(size: 60))
                .foregroundColor(.white)
                .padding()
                .background(Circle().fill(Color.blue))
                .shadow(radius: 10)

            Text("Enter Password")
                .font(.title2)
                .fontWeight(.bold)

            SecureField("Password", text: $password)
                .padding()
                .background(RoundedRectangle(cornerRadius: 15).stroke(Color.gray.opacity(0.7), lineWidth: 1))
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
                    onUnlock(password)
                    show = false
                }) {
                    Text("Unlock")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
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
