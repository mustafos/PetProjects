//
//  CourseViewCover.swift
//  SwiftUIConcurrencyFinal
//
//  Created by Stephanie Diep on 2021-06-22.
//

import SwiftUI

struct CourseViewCover: View {
    var course: Course
    
    var body: some View {
        VStack {
            CourseViewTitle(course: course)
                .accessibilityAddTraits([.isHeader])
            
            Spacer()
            ZStack(alignment: .bottom) {
                AsyncImage(url: URL(string: course.illustration)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 400, maxHeight: 220, alignment: .top)

                } placeholder: {
                    Rectangle()
                        .foregroundColor(.gray.opacity(0.2))
                }

                CourseViewSubtitle(subtitle: course.subtitle)
            }
        }
        .padding(.top, 110)
        .frame(maxWidth: .infinity, alignment: .center)
        .frame(height: 550)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.init(hex: course.colors.first!!),Color.init(hex: course.colors.last!!)]), startPoint: .bottomLeading, endPoint: .topTrailing)
        )
        .shadow(color:Color.init(hex: course.colors.last!!).opacity(0.3), radius: 20, x: 0, y: 10)
        .cornerRadius(30)
    }
}

struct CourseViewCover_Previews: PreviewProvider {
    static var previews: some View {
        CourseViewCover(course: coursePreviewData)
    }
}
