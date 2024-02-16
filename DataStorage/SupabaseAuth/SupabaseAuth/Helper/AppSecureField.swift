//
//  AppSecureField.swift
//  SupabaseAuth
//
//  Created by Mustafa Bekirov on 29.08.2023.
//

import SwiftUI

struct AppSecureField: View {
    var placeholder: String
    @Binding var text: String
    
    var body: some View {
        SecureField(placeholder, text: $text)
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color(uiColor: .black), lineWidth: 1)
            }
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
    }
}

struct AppSecureField_Previews: PreviewProvider {
    static var previews: some View {
        AppSecureField(placeholder: "Password", text: .constant(""))
    }
}
