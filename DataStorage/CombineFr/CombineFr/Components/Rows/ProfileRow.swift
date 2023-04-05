//
//  ProfileRow.swift
//  CombineFr
//
//  Created by Mustafa Bekirov on 05.04.2023.
//

import SwiftUI

struct ProfileRow: View {
    @AppStorage("isLiteMode") var isLiteMode: Bool = false

    var body: some View {
        HStack(alignment: .center, spacing: 16.0) {
            profilePicture
            
            VStack(alignment: .leading, spacing: 2) {
                Text("Mustafa Bekirov")
                    .font(.title2)
                    .fontWeight(.bold)
                    .lineLimit(1)
                    .foregroundColor(.white)
                
                Text("View Certificates")
                    .font(.footnote)
                    .foregroundColor(Color.white.opacity(0.7))
            }
            
            Spacer()
            
            glowIcon
        }
        .blurBackground()
    }
    
    var profilePicture: some View {
        ZStack {
            Image(systemName: "circle.fill")
                .resizable()
                .font(.system(size: 66))
                .angularGradientGlow(colors: [Color(#colorLiteral(red: 0.2274509804, green: 0.4, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.2156862745, green: 1, blue: 0.6235294118, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.9176470588, blue: 0.1960784314, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.2039215686, blue: 0.2745098039, alpha: 1))])
                .frame(width: 66, height: 66)
                .if(!isLiteMode, transform: { view in
                    view
                .blur(radius: 10)
                })
                
            VStack {
                Image("Profile")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 66, height: 66, alignment: .center)
                    .cornerRadius(50)
            }
            .overlay(
                Circle()
                    .stroke(style: StrokeStyle(lineWidth: 2))
                    .foregroundColor(Color.white.opacity(0.7))
            )
        }
    }
    
    var glowIcon: some View {
        ZStack {
            if !isLiteMode {
                AngularGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3960784314, green: 0.5254901961, blue: 1, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.2509803922, blue: 0.3137254902, alpha: 1)), Color(#colorLiteral(red: 0.4274509804, green: 1, blue: 0.7254901961, alpha: 1)), Color(#colorLiteral(red: 0.4274509804, green: 1, blue: 0.7254901961, alpha: 1))]), center: .center, startAngle: .init(degrees: -190), endAngle: .degrees(155))
                    .blur(radius: 8)
                    .shadow(radius: 30)
                    .frame(width: 36, height: 36)
            }
            
            Image(systemName: "square.stack.fill")
                .linearGradientBackground(colors: [Color(#colorLiteral(red: 0.6196078431, green: 0.6784313725, blue: 1, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.5607843137, blue: 0.9803921569, alpha: 1))])
                .frame(width: 36.0, height: 36)
                .background(Color(#colorLiteral(red: 0.1019607843, green: 0.07058823529, blue: 0.2431372549, alpha: 1)).opacity(0.8))
                .mask(RoundedRectangle(cornerRadius: 12, style: .continuous))
                .overlay(RoundedRectangle(cornerRadius: 12, style: .continuous).stroke(Color.white.opacity(0.7), lineWidth: 1).blendMode(.overlay))
        }
    }
}

struct ProfileRow_Previews: PreviewProvider {
    static var previews: some View {
        ProfileRow()
    }
}

