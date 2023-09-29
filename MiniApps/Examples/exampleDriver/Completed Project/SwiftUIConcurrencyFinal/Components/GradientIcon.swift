//
//  GradientIcon.swift
//  SwiftUIConcurrencyFinal
//
//  Created by Stephanie Diep on 2021-06-18.
//

import SwiftUI

struct GradientIcon: View {
    var icon: String = "envelope.fill"
    var gradient: Array<Color> = [Color(#colorLiteral(red: 0.5098039216, green: 0.2549019608, blue: 0.737254902, alpha: 1)), Color(#colorLiteral(red: 0.8823529412, green: 0.2823529412, blue: 0.5215686275, alpha: 1)), Color(#colorLiteral(red: 0.9843137255, green: 0.6470588235, blue: 0.5450980392, alpha: 1))]
    
    var body: some View {
        ZStack {
            Image(systemName: icon)
                .frame(width: 36, height: 36)
                .background(LinearGradient(gradient: Gradient(colors: gradient), startPoint: .top, endPoint: .bottom))
                .cornerRadius(12)
                .foregroundColor(.white)
        }
    }
}


struct GradientIcon_Previews: PreviewProvider {
    static var previews: some View {
        GradientIcon()
    }
}
