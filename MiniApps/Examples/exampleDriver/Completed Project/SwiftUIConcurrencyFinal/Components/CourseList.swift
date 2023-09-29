//
//  CourseList.swift
//  SwiftUIConcurrencyFinal
//
//  Created by Stephanie Diep on 2021-06-16.
//

import SwiftUI

struct CourseList: View {
    @EnvironmentObject var contentViewModel: CourseViewModel
    var courses: [Course]
    var columns = [GridItem(.adaptive(minimum: 160), spacing: 15)]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 15) {
            if courses.count > 0 {
                ForEach(courses, id: \.id) { course in
                    NavigationLink(destination: CourseView(course: course)) {
                        CourseCard(course: course)
                    }
                }
            } else {
                ForEach(0..<4, id: \.self) { number in
                    CourseCard(course: coursePreviewData)
                        .redacted(reason: .placeholder)
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
    }
}

struct CourseList_Previews: PreviewProvider {
    static var previews: some View {
        CourseList(courses: [coursePreviewData])
    }
}
