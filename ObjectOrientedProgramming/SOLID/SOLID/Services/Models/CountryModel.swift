//
//  CountryModel.swift
//  SOLID
//
//  Created by Mustafa Bekirov on 21.02.2023.
//  Copyright © 2023 Mustafa Bekirov. All rights reserved.

import Foundation

struct Country: Decodable {
    var Id: String
    var Time: String
    var Name: String
    var Image: String?
}
