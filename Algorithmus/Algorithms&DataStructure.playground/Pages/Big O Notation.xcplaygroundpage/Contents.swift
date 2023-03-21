/*Big O notation (aka Big O) is a way assessing the relative performance of a data structure or algorithm usually along two axis: time and space.
 */

import Foundation

func findNemo(_ arr: [String]) {
    let before = Date()
    
    for i in 0..<arr.count {
        if arr[i] == "nemo" {
            print("Found him")
        }
    }
    
    let after = Date()
    let component = Calendar.current.dateComponents([.nanosecond], from: before, to: after)
    let milliSeconds: Double = Double(component.nanosecond! / 1000000)
    print("Finding nemo took: \(milliSeconds)")
}

let nemo = Array<String>(repeating: "🐠", count: 5)
findNemo(nemo)

/**Constant time – O(1)**/
func constantTime(_ n: Int) -> Int {
    let result = n * n
    return result
}

/**Linear time – O(n)**/
func linearTime(_ A: [Int]) -> Int {
    for i in 0..<A.count {
        if A[i] == 0 {
            return 0
        }
    }
    return 1
}

/**Logarithmic time – O(log n)**/
func logarithmicTime(_ N: Int) -> Int {
    var n = N
    var result = 0
    while n > 1 {
        n /= 2
        result += 1
    }
    return result
}

/**Quadratic time - O(n^2)**/
func quadratic(_ n: Int) -> Int {
    var result = 0
    for i in 0..<n {
        for j in i..<n {
            result += 1
            print("\(i) \(j)")
        }
    }
    return result
}

// Naive brute force O(n^2)
func commonItemsBrute(_ A: [Int], _ B: [Int]) -> Bool {
    for i in 0..<A.count {
        for j in 0..<B.count {
            if A[i] == B[j] {
                return true
            }
        }
    }
    return false
}
commonItemsBrute([1, 2, 3], [4, 5, 6])
commonItemsBrute([1, 2, 3], [3, 5, 6])

// Convert to hash and lookup via other index
func commonItemsHash(_ A: [Int], _ B: [Int]) -> Bool {
    
    // Still looping...but not nested - O(2n) vs O(n^2)
    var hashA = [Int: Bool]()
    for a in A { // O(n)
        hashA[a] = true
    }
    
    // Now lookup in the hash to see if elements of B exist
    for b in B {
        if hashA[b] == true {
            return true
        }
    }
    return false
}
commonItemsHash([1, 2, 3], [4, 5, 6])
commonItemsHash([1, 2, 3], [3, 5, 6])
