//
//  OTPTextField.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 20.02.2024.
//

import SwiftUI
import Combine

struct OTPTextField: View {
    @FocusState private var keyboardFocusField: FocusField?
    @Binding var verificationCode: String
    @State private var isAllNumbersFilled: Bool = false
    
    var pinLength = 6
    var keyboardType: UIKeyboardType = .numberPad
    var onComplete: () -> ()
    
    var body: some View {
        ZStack {
            TextField("", text: $verificationCode)
                .frame(width: 0, height: 0, alignment: .center)
                .font(Font.system(size: 0))
                .accentColor(.white)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .keyboardType(keyboardType)
                .focused($keyboardFocusField, equals: .field)
                .padding()
                .task {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.keyboardFocusField = .field
                    }
                }
                .onReceive(Just(verificationCode)) { _ in
                    if verificationCode.count > pinLength {
                        verificationCode = String(verificationCode.prefix(pinLength))
                    }
                    if verificationCode.count == pinLength && !isAllNumbersFilled {
                        onComplete()
                    } else if verificationCode.count < pinLength {
                        isAllNumbersFilled = false
                    }
                }
        }
    }
}

