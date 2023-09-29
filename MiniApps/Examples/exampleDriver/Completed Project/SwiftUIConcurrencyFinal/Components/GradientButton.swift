//
//  GradientButton.swift
//  SwiftUIConcurrencyFinal
//
//  Created by Stephanie Diep on 2021-06-18.
//

import SwiftUI

struct GradientButton: View {
    var text: String
    var gradient: Array<Color> = [Color(#colorLiteral(red: 0.7294117647, green: 0.4588235294, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.2235294118, green: 0.07450980392, blue: 0.7215686275, alpha: 1))]
    
    var body: some View {
        
        Text(text)
            .font(.headline)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(LinearGradient(gradient: Gradient(colors: gradient), startPoint: .top, endPoint: .bottom))
            .cornerRadius(16)
            .foregroundColor(.white)
    }
}

struct GradientButton_Previews: PreviewProvider {
    static var previews: some View {
        GradientButton(text: "Text here")
    }
}
