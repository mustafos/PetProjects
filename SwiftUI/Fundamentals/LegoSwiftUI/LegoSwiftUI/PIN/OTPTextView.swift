//
//  OTPTextView.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 20.02.2024.
//

import SwiftUI

struct OTPTextView: View {
    @State private var verificationCode = ""
    @FocusState private var focusField: FocusField?
    var pinLength = 6
    var keyboardType: UIKeyboardType = .numberPad
    var onComplete: (String) -> ()
    
    var body: some View {
        ZStack(alignment: .center) {
            OTPTextField(verificationCode: $verificationCode, pinLength: pinLength, keyboardType: keyboardType) {
                onComplete(verificationCode)
            }
            HStack {
                ForEach(0..<pinLength, id: \.self) { i in
                    ZStack {
                        Text(getPin(at: i))
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                        
                        Rectangle()
                            .frame(height: 3)
                            .foregroundColor(.white)
                            .padding(.trailing, 5)
                            .padding(.leading, 5)
                            .opacity(verificationCode.count <= i ? 1 : 0)
                    }
                }
            }
        }
        .onAppear {
            UITextField.appearance().clearButtonMode = .never
            UITextField.appearance().tintColor = UIColor.clear
        }
    }
    
    func getPin(at index: Int) -> String {
        guard self.verificationCode.count > index else { return "" }
        return String(verificationCode[index])
    }
}
