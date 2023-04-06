//
//  Certificate.swift
//  CombineFr
//
//  Created by Mustafa Bekirov on 05.04.2023.
//

import Foundation

struct Certificate: Identifiable, Decodable {
    var id: String
    var course: String
    var date: String
    var logo: String
    var instructor: String
}
