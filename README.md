<h1 align="center">PetProjects</h1>
<p align="center">
  <i>Arte et humanitate, labore et scientia</i>
  <img src="https://github.com/mustafos/PetProjects/blob/main/pet_banner.png" alt="PetProject" width="100%"/>
</p>

## 📌 Topics
This repository, PetProject, is a testament to my iOS development skills and technological prowess. It showcases the synergy of Swift, UIKit, SwiftUI, and other technologies in action as I craft elegant solutions to complex challenges. From sleek UI design to seamless data management, this repository reveals the artistry and innovation inherent in iOS development.
* [**Swift**](https://github.com/mustafos/PetProjects/tree/main/MiniApps/ShopApp)
* [**UIKit**](https://github.com/mustafos/PetProjects/tree/main/MiniApps)
* [**SwiftUI**](https://github.com/mustafos/PetProjects/tree/main/SwiftUI)
* [**Figma**](https://github.com/mustafos/PetProjects/tree/main/UserInterfaceDesign)
* [**TDD**](https://github.com/mustafos/PetProjects/tree/main/TDD)
* [**OOP**](https://github.com/mustafos/PetProjects/tree/main/ObjectOrientedProgramming)
* [**Networking**](https://github.com/mustafos/PetProjects/tree/main/Networking)
* [**Algorithms**](https://github.com/mustafos/PetProjects/tree/main/Algorithms)
* [**Architecture**](https://github.com/mustafos/PetProjects/tree/main/Architecture)
* [**ARKit**](https://github.com/mustafos/PetProjects/tree/main/ARKit)
* [**SpriteKit**](https://github.com/mustafos/PetProjects/tree/main/SpriteKit)
* [**Metal**](https://github.com/mustafos/PetProjects/tree/main/Metal/MetalRenderer)
* [**WebView**](https://github.com/mustafos/PetProjects/tree/main/Metal/WebView)
* [**StoreKit**](https://github.com/mustafos/PetProjects/tree/main/Metal/StoreKit)
* [**LearnApp**](https://github.com/mustafos/PetProjects/tree/main/Concurrency)
* [**CryptoApp**](https://github.com/mustafos/PetProjects/tree/main/CryptoApp)
* [**UtilitiesApp**](https://github.com/mustafos/PetProjects/tree/main/UtilitiesApp)

## 📌 My First Programm
The program demonstrates basic input/output operations, function definition and invocation, conditional statements, loops, type conversion, and random generation in Swift. It's a good starting point for learning to program in Swift and demonstrates the language's fundamental concepts.
```swift
//
//  main.swift
//  FirstApp
//
//  Created by Mustafa Bekirov on 18.04.2022.
//  Copyright © 2022 Mustafa Bekirov. All rights reserved.

import Foundation

print("Enter the first value")
// first value retrieval
var a = readLine()
print("Enter the second value")
// second value retrieval
var b = readLine()

let result = sum(a, b)
print("The result of adding is \(result)")

func sum(_ a: String?, _ b: String?) -> Int {
    return Int(a!)! + Int(b!)!
}
//_____________________________________________
// Random number
let randomNumber = UInt8.random(in: 1...250)
print("Enter a number option from 1 to 250 and press Enter")
// victory flag
var isWin = false
repeat {
    // attempt to convert the entered value to UInt8
    guard let userNumber = UInt8(readLine() ?? "") else {
        print("You have entered an incorrect number. Try again")
continue }
    // validation of the entered number
    if userNumber < randomNumber{
        print("Your option is less than the number given")
    } else if userNumber > randomNumber {
        print("Your option is greater than the mystery number")
    } else {
        print("You guessed it")
isWin = true }
} while !isWin
```
## 📌 License

This app is open-sourced software licensed under the [MIT license](https://github.com/mustafos/PetProjects/blob/main/LICENSE).
