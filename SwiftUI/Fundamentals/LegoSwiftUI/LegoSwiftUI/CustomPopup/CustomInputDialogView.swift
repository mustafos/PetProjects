//
//  CustomInputDialogView.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 13.10.2024.
//

import SwiftUI

struct CustomInputDialogView: View {
    @Binding var show: Bool
    var onSubmit: (String) -> Void
    @State private var inputText: String = ""

    var body: some View {
        VStack(spacing: 25) {
            Image(systemName: "square.and.pencil")
                .font(.system(size: 60))
                .foregroundColor(.white)
                .padding()
                .background(Circle().fill(Color.purple))
                .shadow(radius: 10)

            Text("Enter Text")
                .font(.title2)
                .fontWeight(.bold)

            TextField("Your input", text: $inputText)
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
                    onSubmit(inputText)
                    show = false
                }) {
                    Text("Submit")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.purple)
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


