//
//  Post.swift
//  LazyLoadGallery
//
//  Created by Mustafa Bekirov on 28.05.2024.
//

import Foundation

struct Post: Codable, Hashable {
    let title: String
    let description: String
    let imageURL: String
}
