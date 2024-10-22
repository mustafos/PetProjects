//
//  HapticFeedback.swift
//  vpn_app
//
//  Created by Mustafa Bekirov on 04.09.2024.
//

import SwiftUI

class HapticFeedback {
#if os(watchOS)
    // watchOS implementation
    static func playSelection() {
        WKInterfaceDevice.current().play(.click)
    }
    
#elseif os(iOS)
    // iOS implementation
    let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
    static func playSelection() {
        UISelectionFeedbackGenerator().selectionChanged()
    }
#else
    static func playSelection() {
        // No-op
    }
#endif
}
