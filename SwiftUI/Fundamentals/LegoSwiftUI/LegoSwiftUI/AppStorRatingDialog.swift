//
//  AppStorRatingDialog.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 01.04.2024.
//

import SwiftUI
import StoreKit

struct AppStorRatingDialog: View {
    @Environment(\.requestReview) var requestReview
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            Button {
                requestReview()
            } label: {
                Text("Rate Us")
            }
        }
    }
}

#Preview {
    AppStorRatingDialog()
}
