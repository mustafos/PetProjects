//
//  View+Extensions.swift
//  ReduxApp
//
//  Created by Mustafa Bekirov on 04.01.2025.
//

import SwiftUI

extension View {
    func embedInNavigationView() -> some View {
        NavigationView { self }
    }
}
