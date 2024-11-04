//
//  Item.swift
//  Foodzilla
//
//  Created by Caleb Stultz on 9/14/17.
//  Copyright © 2017 Caleb Stultz. All rights reserved.
//

import UIKit

class Item {
    public private(set) var image: UIImage
    public private(set) var name: String
    public private(set) var price: Double
    
    init(image: UIImage, name: String, price: Double) {
        self.image = image
        self.name = name
        self.price = price
    }
}
