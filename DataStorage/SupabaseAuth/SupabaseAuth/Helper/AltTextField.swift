//
//  AltTextField.swift
//  SupabaseAuth
//
//  Created by Mustafa Bekirov on 29.08.2023.
//

import SwiftUI

struct AltTextField: View {
    var placeholder: String
    @Binding var text: String
    
    var body: some View {
        TextField(placeholder, text: $text)
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color(uiColor: .secondaryLabel), lineWidth: 1)
            }
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
    }
}

struct AltTextField_Previews: PreviewProvider {
    static var previews: some View {
        AltTextField(placeholder: "Email address", text: .constant(""))
    }
}
