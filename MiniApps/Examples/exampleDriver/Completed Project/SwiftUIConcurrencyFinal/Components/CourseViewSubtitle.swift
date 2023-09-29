//
//  CourseViewSubtitle.swift
//  SwiftUIConcurrencyFinal
//
//  Created by Stephanie Diep on 2021-06-22.
//

import SwiftUI

struct CourseViewSubtitle: View {
    var subtitle: String
    
    var body: some View {
        VStack(spacing: 16) {
            Text(subtitle)
                .font(.subheadline)
                .foregroundColor(.white)
                .lineLimit(3)
                .multilineTextAlignment(.center)
                .frame(maxWidth: 712)
        }
        .padding(20)
        .frame(maxWidth: .infinity)
        .overlay(
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .stroke(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), lineWidth: 1)
                .blendMode(.overlay)
        )
        .background(Color(#colorLiteral(red: 0.1568627451, green: 0.1058823529, blue: 0.3529411765, alpha: 1)).opacity(0.2))
        .background(.ultraThinMaterial)
        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .frame(maxWidth: .infinity, alignment: .center)

    }
}

struct CourseViewSubtitle_Previews: PreviewProvider {
    static var previews: some View {
        CourseViewSubtitle(subtitle: coursePreviewData.subtitle)
    }
}
