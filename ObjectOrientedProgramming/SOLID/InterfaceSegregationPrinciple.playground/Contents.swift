import UIKit

let solid = "InterfaceSegregationPrinciple"

protocol Volatilisation {
    func fly()
}

protocol Buoyancy {
    func swim()
}

class Individual: Volatilisation, Buoyancy {
    func fly() {
        print("Людина нібито не літає… А крила має. А крила має!")
    }
    
    func swim() {
        print("I can swim!")
    }
}

class Duck: Volatilisation, Buoyancy {
    func fly() {
        print("I can fly a lot!")
    }
    
    func swim() {
        print("I can swim a lot!")
    }
}

class Penguin: Buoyancy {
    
    func swim() {
        print("Swim is my life!")
    }
}

let penguin1 = Penguin()
penguin1.swim()

let duck1 = Duck()
duck1.fly()
duck1.swim()

let person = Individual()
person.fly()
