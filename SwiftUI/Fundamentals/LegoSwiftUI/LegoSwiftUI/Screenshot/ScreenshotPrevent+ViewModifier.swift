//
//  ScreenshotPrevent+ViewModifier.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 12.03.2024.
//

import SwiftUI

public struct PreventScreenshot: ViewModifier {
    public let isProtected: Bool
    
    public func body(content: Content) -> some View {
        SecureView(preventScreenCapture: isProtected) {
            content
        }
    }
}

public extension View {
    func screenshotProtected(isProtected: Bool) -> some View {
        modifier(PreventScreenshot(isProtected: isProtected))
    }
}
