//
//  CourseViewTitle.swift
//  SwiftUIConcurrencyFinal
//
//  Created by Stephanie Diep on 2021-06-22.
//

import SwiftUI

struct CourseViewTitle: View {
    var course: Course
    
    var body: some View {
        VStack(spacing: 4) {
            Text(course.title)
                .font(.largeTitle)
                .bold()
                .foregroundColor(.white)
                .frame(maxWidth: 300, alignment: .leading)
                .padding(.horizontal, 20)
                .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.25), radius: 40, x: 0, y: 10)
                .fixedSize(horizontal: false, vertical: true)
            
            Text("\(course.sectionCollection?.sections.count ?? 0) sections - \(course.numberOfHours) hours")
                .font(.footnote)
                .foregroundColor(Color.white.opacity(0.7))
                .frame(maxWidth: 300, alignment: .leading)
                .padding(.horizontal, 20)
        }
    }
}

struct CourseViewTitle_Previews: PreviewProvider {
    static var previews: some View {
        CourseViewTitle(course: coursePreviewData)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.init(hex: coursePreviewData.colors.first!!))
    }
}
