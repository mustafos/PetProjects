//
//  UIApplication.swift
//  CryptoApp
//
//  Created by Mustafa Bekirov on 22.07.2024.
//  Copyright © 2024 Mustafa Bekirov. All rights reserved.

import SwiftUI

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
