import UIKit

public protocol Copying {
    init(_ prototype: Self)
}

extension Copying {
    public func copy() -> Self {
        return type(of: self).init(self)
    }
}

extension Array where Element: Copying {
    public func deepCopy() -> [Element] {
        return map { $0.copy() }
    }
}

// ==============================================================
class Person: Copying {
    
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    required convenience init(_ prototype: Person) {
        self.init(name: prototype.name)
    }
}

var person1 = Person(name: "Jim")

var person2 = person1.copy()

print(person1 === person2)
