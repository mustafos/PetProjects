//
//  WeatherButton.swift
//  WeatherA
//
//  Created by Mustafa Bekirov on 26.10.2023.
//

import SwiftUI

struct WeatherButton: View {
    var title: String
    var textColor: Color
    var backgroundColor: Color
    
    var body: some View {
        VStack(spacing: 20) {
            Text(title)
                .bold()
                .frame(width: 200, height: 50)
                .background(backgroundColor)
                .cornerRadius(15)
            
            Text(title)
                .frame(width: 200, height: 50)
                .background(backgroundColor)
                .cornerRadius(15)
        }
        .foregroundColor(textColor)
    }
}


#Preview {
    WeatherButton(title: "Weather Button", textColor: .white, backgroundColor: .cyan)
}
