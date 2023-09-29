//
//  FeaturedCourseCard.swift
//  SwiftUIConcurrencyFinal
//
//  Created by Stephanie Diep on 2021-06-15.
//

import SwiftUI

struct FeaturedCourseCard: View {
    var featuredCourse: Course
    
    var body: some View {
        VStack(spacing: 8) {
            AsyncImage(url: URL(string: featuredCourse.illustration)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: 220, alignment: .center)

            } placeholder: {
                Rectangle()
                    .foregroundColor(.gray.opacity(0.2))
            }
             
            Spacer()
            
            Text(featuredCourse.title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
            
            Text("\(featuredCourse.numberOfSections) sections - \(featuredCourse.numberOfHours) hours")
                .font(.footnote)
                .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.7)))
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(1)
                .multilineTextAlignment(.leading)

            Text(featuredCourse.subtitle)
                .font(.footnote)
                .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.7)))
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(2)
                .multilineTextAlignment(.leading)

        }
        .padding(16)
        .frame(width: 252, height: 350, alignment: .top)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.init(hex: featuredCourse.colors.first!!), Color.init(hex: featuredCourse.colors.last!!)]), startPoint: .top, endPoint: .bottomLeading)
        )
        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 30, style: .continuous)
                .stroke(Color.white.opacity(0.2), lineWidth: 0.5)
                .blendMode(.overlay))

    }
    
}

struct FeaturedChapterCard_Previews: PreviewProvider {
    static var previews: some View {
        FeaturedCourseCard(featuredCourse: coursePreviewData)
    }
}
