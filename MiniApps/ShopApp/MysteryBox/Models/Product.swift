//
//  Product.swift
//  MysteryBox
//
//  Created by Mustafa Bekirov on 11.09.2022.
//

import Foundation

struct Product: Identifiable {
    var id = UUID()
    var name: String
    var image: String
    var price: Int
}

var productList = [Product(name: "MYSTERY BOX", image: "boxH", price: 399),
                   Product(name: "Apple Box", image: "box1", price: 399),
                   Product(name: "Gaming Box", image: "box2", price: 399),
                   Product(name: "Hobby Box", image: "box3", price: 399)]
        
