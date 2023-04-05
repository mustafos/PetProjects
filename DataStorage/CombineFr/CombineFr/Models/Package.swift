//
//  Package.swift
//  CombineFr
//
//  Created by Mustafa Bekirov on 05.04.2023.
//

import Foundation

struct Package: Identifiable {
    var id = UUID()
    var title: String
    var link: String
}

let packagesData = [
    Package(title: "Firebase", link: "https://github.com/firebase/firebase-ios-sdk"),
    Package(title: "SDWebImageSwiftUI", link: "https://github.com/SDWebImage/SDWebImageSwiftUI"),
    Package(title: "SwiftUITrackableScrollView", link: "https://github.com/maxnatchanon/trackable-scroll-view"),
    Package(title: "SwiftUIX", link: "https://github.com/swiftuix/SwiftUIX")
]
