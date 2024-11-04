//
//  FoodItems.swift
//  Foodzilla
//
//  Created by Caleb Stultz on 9/14/17.
//  Copyright © 2017 Caleb Stultz. All rights reserved.
//

import UIKit

let defaultPrice = 9.99

let salmon = Item(image: UIImage(named: "food1")!, name: "Salmon", price: defaultPrice)
let cheeseburger = Item(image: UIImage(named: "food2")!, name: "Cheeseburger", price: defaultPrice)
let burrito = Item(image: UIImage(named: "food3")!, name: "Burrito", price: defaultPrice)
let spaghetti = Item(image: UIImage(named: "food4")!, name: "Spaghetti", price: defaultPrice)
let pizza = Item(image: UIImage(named: "food5")!, name: "Pizza", price: defaultPrice)
let salad = Item(image: UIImage(named: "food6")!, name: "Salad", price: defaultPrice)

let foodItems: [Item] = [salmon, cheeseburger, burrito, spaghetti, pizza, salad]
