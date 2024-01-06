//
//  FontView.swift
//  WeatherA
//
//  Created by Mustafa Bekirov on 15.12.2023.
//

import SwiftUI

struct FontView: View {
    var body: some View {
        Text("Custom Font")
            .font(.custom("Zapfino", size: 52, relativeTo: .largeTitle))
    }
    
    // MARK: - Check font name
    init() {
        for familyName in UIFont.familyNames {
            print(familyName)
            
            for fontName in UIFont.fontNames(forFamilyName: familyName) {
                print("-- \(fontName)")
            }
        }
    }
}

#Preview {
    FontView()
}
