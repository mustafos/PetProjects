//
//  CourseItem.swift
//  LearnApp
//
//  Created by Mustafa Bekirov on 03.04.2023.
//

import SwiftUI

struct CourseItem: View {
    var namespace: Namespace.ID
    var course: Course
    
    @EnvironmentObject var model: Model
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        VStack {
            LogoView(image: course.logo)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(20)
                .matchedGeometryEffect(id: "logo\(course.index)", in: namespace)
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 8) {
                Text(course.title)
                    .font(.title).bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .matchedGeometryEffect(id: "title\(course.index)", in: namespace)
                    .foregroundColor(.white)
                
                Text("20 videos - 3 hours".uppercased())
                    .font(.footnote).bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .matchedGeometryEffect(id: "subtitle\(course.index)", in: namespace)
                    .foregroundColor(.white.opacity(0.7))
                
                Text("A complete guide to designing for iOS 14 with videos, examples and design...")
                    .font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.white.opacity(0.7))
                    .matchedGeometryEffect(id: "description\(course.index)", in: namespace)
            }
            .padding(20)
            .background(
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .cornerRadius(30)
                    .blur(radius: 30)
                    .matchedGeometryEffect(id: "blur\(course.index)", in: namespace)
            )
        }
        .background(
            Image(course.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(20)
                .matchedGeometryEffect(id: "image\(course.index)", in: namespace)
                .offset(y: -30)
        )
        .background(
            Image(course.background)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .disabled(true)
                .matchedGeometryEffect(id: "background\(course.index)", in: namespace)
        )
        .mask(
            RoundedRectangle(cornerRadius: 30)
                .matchedGeometryEffect(id: "mask\(course.index)", in: namespace)
        )
        .overlay(
            Image(horizontalSizeClass == .compact ? "Waves 1" : "Waves 2")
                .frame(maxHeight: .infinity, alignment: .bottom)
                .offset(y: 0)
                .opacity(0)
                .matchedGeometryEffect(id: "waves\(course.index)", in: namespace)
        )
        .onTapGesture {
            withAnimation(.openCard) {
                model.showDetail = true
                model.selectedCourse = course.index
            }
        }
    }
}

struct CardItem_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        CourseItem(namespace: namespace, course: courses[0])
            .environmentObject(Model())
    }
}

