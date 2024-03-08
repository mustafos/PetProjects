//
//  SectionView.swift
//  LearnApp
//
//  Created by Mustafa Bekirov on 04.04.2023.
//

import SwiftUI

struct SectionView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var section: CourseSection
    
    var body: some View {
        ZStack {
            ScrollView {
                cover
                    .overlay(PlayButton())
                content
                    .padding(.vertical, 80)
            }
            .coordinateSpace(name: "scroll")
            .background(Color("Background"))
            .ignoresSafeArea()
            
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                CloseButton()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding(20)
            .ignoresSafeArea()
            
            LogoView(image: section.logo)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(20)
                .ignoresSafeArea()
                .accessibility(hidden: true)
        }
        .zIndex(1)
    }
    
    var cover: some View {
        VStack {
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 500)
        .background(
            Image(section.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(20)
                .accessibility(hidden: true)
        )
        .background(
            Image(section.background)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .accessibility(hidden: true)
        )
        .mask(
            RoundedRectangle(cornerRadius: 0)
        )
        .overlay(
            Image(horizontalSizeClass == .compact ? "Waves 1" : "Waves 2")
                .frame(maxHeight: .infinity, alignment: .bottom)
                .accessibility(hidden: true)
        )
        .overlay(
            VStack(alignment: .leading, spacing: 8) {
                
                Text("SwiftUI for iOS 15".uppercased())
                    .font(.footnote).bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.primary.opacity(0.7))
                
                Text(section.title)
                    .font(.title).bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.primary)
                
                Text("A complete guide to designing for iOS 14 with videos, examples and design...")
                    .font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.primary.opacity(0.7))
                
                Divider()
                    .foregroundColor(.secondary)
                
                HStack {
                    LogoView(image: "Avatar 1")
                        .accessibility(hidden: true)
                    Text("Taught by Mustafa Bekirov")
                        .font(.footnote.weight(.medium))
                        .foregroundStyle(.secondary)
                }
                .accessibilityElement(children: .combine)
            }
                .padding(20)
                .background(
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .backgroundStyle(cornerRadius: 30)
                )
                .frame(maxHeight: .infinity, alignment: .bottom)
                .padding(20)
                .offset(y: 100)
        )
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 30) {
            Text("SwiftUI is hands-down the best way for designers to take a first step into code. ")
                .font(.title3).fontWeight(.medium)
            Text("This course")
                .font(.title).bold()
            Text("This course is unlike any other. We care about design and want to make sure that you get better at it in the process. It was written for designers and developers who are passionate about collaborating and building real apps for iOS and macOS. While it's not one codebase for all apps, you learn once and can apply the techniques and controls to all platforms with incredible quality, consistency and performance. It's beginner-friendly, but it's also packed with design tricks and efficient workflows for building great user interfaces and interactions.")
            Text("This year, SwiftUI got major upgrades from the WWDC 2020. The big news is that thanks to Apple Silicon, Macs will be able to run iOS and iPad apps soon. SwiftUI is the only framework that allows you to build apps for all of Apple's five platforms: iOS, iPadOS, macOS, tvOS and watchOS with the same codebase. New features like the Sidebar, Lazy Grid, Matched Geometry Effect and Xcode 12's visual editing tools will make it easier than ever to build for multiple platforms.")
            Text("Multiplatform app")
                .font(.title).bold()
            Text("For the first time, you can build entire apps using SwiftUI only. In Xcode 12, you can now create multi-platform apps with minimal code changes. SwiftUI will automatically translate the navigation, fonts, forms and controls to its respective platform. For example, a sidebar will look differently on the Mac versus the iPad, while using exactly the same code. Dynamic type will adjust for the appropriate platform language, readability and information density. ")
        }
        .padding(20)
    }
}

struct SectionView_Previews: PreviewProvider {
    static var previews: some View {
        SectionView(section: .constant(courseSections[0]))
    }
}

