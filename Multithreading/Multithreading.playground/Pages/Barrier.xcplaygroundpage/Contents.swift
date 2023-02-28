import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

var greeting = "Barrier"

var array = [Int]()
 SerialQueue
for i in 0...9 {
    array.append(i)
}
print(array)
print(array.count)

DispatchQueue.concurrentPerform(iterations: 10) { (index) in
    array.append(index)
}

print(array)
print(array.count)

class SafeArray<T> {
    private var array = [T]()
    private let queue = DispatchQueue(label: "@mustafos", attributes: .concurrent)
    
    public func append(_ value: T) {
        queue.async(flags: .barrier) {
            self.array.append(value)
        }
    }
    
    public var valueArray: [T] {
        var result = [T]()
        queue.sync {
            result = self.array
        }
        return result
    }
}

var arraySafe = SafeArray<Int>()
DispatchQueue.concurrentPerform(iterations: 10) { (index) in
    arraySafe.append(index)
}

print("arraySafe", arraySafe.valueArray)
print("arraySafeCount", arraySafe.valueArray.count)
