//
//  TextFieldEx.swift
//  ProUISwift
//
//  Created by Mustafa Bekirov on 17.05.2023.
//

import SwiftUI

struct TextFieldEx: View {
    @State var text = ""
    @FocusState var nameIsFocused: Bool
    
    var body: some View {
        VStack(spacing: 24) {
            TextField("Enter youre login", text: $text)
                .redTextField()
                .focused($nameIsFocused)
            TextField("Add password", text: $text) {
                changed in
                print(changed)
            } onCommit: {
                print("onCommit")
            }
            .redTextField()
            
            Button {
                nameIsFocused = false
//                hideKeyboard()
            } label: {
                Text("Login")
            }
        }
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension View {
    func redTextField() -> some View {
        modifier(TextFieldModifire())
    }
}

struct TextFieldModifire: ViewModifier {
    func body(content: Content) -> some View {
        content
            .textFieldStyle(.roundedBorder)
            .foregroundColor(.accentColor)
            .font(.system(size: 24))
            .keyboardType(.emailAddress)
            .overlay(
                RoundedRectangle(cornerRadius: 8).stroke(.red)
            )
            .padding(.horizontal)
    }
}

struct TextFieldEx_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldEx()
    }
}
