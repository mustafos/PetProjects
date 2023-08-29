//
//  AppTextField.swift
//  SupabaseAuth
//
//  Created by Mustafa Bekirov on 29.08.2023.
//

import SwiftUI

struct AppTextField: View {
    var placeholder: String
    @Binding var text: String
    
    var body: some View {
        ZStack {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(.black)
                    .padding(.leading)
            }
            TextField(placeholder, text: $text)
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color(uiColor: .black), lineWidth: 1)
                }
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .foregroundColor(.black)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
    }
}

struct AppTextField_Previews: PreviewProvider {
    static var previews: some View {
        AppTextField(placeholder: "Email address", text: .constant(""))
    }
}
