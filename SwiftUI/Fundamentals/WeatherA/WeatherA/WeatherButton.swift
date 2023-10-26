//
//  WeatherButton.swift
//  WeatherA
//
//  Created by Mustafa Bekirov on 26.10.2023.
//

import SwiftUI

struct WeatherButton: View {
    var title: String
    var body: some View {
        Text(title)
            .frame(width: 200, height: 50)
            .background(.white)
            .foregroundColor(.blue)
            .font(.system(size: 20, weight: .bold, design: .rounded))
            .cornerRadius(15)
    }
}


#Preview {
    WeatherButton(title: "Weather Button")
}
