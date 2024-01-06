import Foundation
import XCTest
import UIKit

/**UniqueCharacters**/
func isUnique(_ text: String) -> Bool {
    var foundChars = [Character:Bool]()
    let chars = Array(text)

    for c in chars {
        if foundChars[c] != nil { // Already found
            return false
        }
        foundChars[c] = true
    }
    return true
}

isUnique("ab")
isUnique("aa")
isUnique("abcdefghijklmnopqrstuvwxyz")

/**Permutations**/
func isPermutation(_ text: String, _ perm: String) -> Bool {
    if text.count != perm.count {
        return false
    }
    
    return text.sorted() == perm.sorted()
}

isPermutation("abc", "cba") // true
isPermutation("abc", "xyz") // false

/**URLify**/
func urlify(_ url: String, length: Int) -> String {
    // Create a bucket to hold our final result
    var result = Array<Character>(repeating: " ", count: length)

    // Strip off any space at beginning or end
    let url = url.trimmingCharacters(in: .whitespacesAndNewlines)

    // Loop through url, and insert an ASCII space '%20' whenever we hit a space
    let urlChars = Array(url)

    // Also create a pointer to keep track of where we are in our results array
    var pointer = 0

    for i in 0..<urlChars.count {
        if urlChars[i] != " " {
            result[pointer] = urlChars[i]
            pointer += 1
        } else {
            result[pointer] = "%"
            result[pointer+1] = "2"
            result[pointer+2] = "0"
            pointer = pointer + 3
        }
    }

    return String(result)
}

urlify("My Home Page    ", length: 16) // "My%20Home%20Page"

/**Oneaway**/
func oneAway(_ first: String, _ second: String) -> Bool {
    if abs(first.count - second.count) > 1 {
        return false
    } else if first.count == second.count {
        return oneEditReplace(first, second)
    } else if first.count + 1 == second.count {
        return oneEditInsert(first, second)
    } else if first.count - 1 == second.count {
        return oneEditInsert(second, first)
    }

    return true
}

func oneEditInsert(_ s1: String, _ s2: String) -> Bool {
    var i = 0
    var j = 0
    
    let s1Chars = Array(s1)
    let s2Chars = Array(s2)
    
    while i < s1.count && j < s2.count {
        if s1Chars[i] != s2Chars[j] {
            if i != j {
                return false
            }
            j += 1
        } else {
            i += 1
            j += 1
        }
    }
    return true
}
// If we detect one difference - fine.
// If we detect another - more than one edit away.
func oneEditReplace(_ s1: String, _ s2: String) -> Bool {
    var foundDifference = false
    
    let s1Chars = Array(s1)
    let s2Chars = Array(s2)

    for i in 0..<s1.count {
        if s1Chars[i] != s2Chars[i] {
            if foundDifference {
                return false
            }
            foundDifference = true
        }
    }
    return true
}
oneAway("pale", "paleXXXX")     // false
oneAway("pale", "ple")          // true
oneAway("pales", "pale")        // true
oneAway("pale", "bale")         // true
oneAway("pale", "bake")         // false
oneAway("pale", "bakeerer")     // false

/**Compressor**/
func compress(_ str: String) -> String {
    var compressed = ""
    var count = 0
    let chars = Array(str)
    
    for i in 0..<str.count {
        count += 1
        // If we are at the end of our string
        // or if next char different, append this result
        if i + 1 >= str.count || chars[i] != chars[i + 1] {
            compressed.append(chars[i])
            compressed.append(String(count))
            count = 0
        }
    }
    
    // Return the original string if shorter, or the compressed if longer
    return compressed.count < str.count ? compressed : str
}

compress("aaabb")           // a3b2
compress("aabb")            // aabb
compress("ab")              // ab
compress("abc")             // abc
compress("zzz")             // z3
compress("aabbaabb")        // aabbaabb (not shorter)

/**Remove duplicates**/
func printLinkedListSimple(_ head: Node?) {
    if head == nil { return }
    
    var node = head
    print(node!.data)
    
    while node?.next != nil {
        print(node!.next!.data)
        node = node?.next
    }
}

class Node {
    var data: Int
    var next: Node?
    
    init(_ data: Int, _ next: Node? = nil) {
        self.data = data
        self.next = next
    }
}

func removeDuplictates(_ head: Node?) {
    // Create a hash table or set to store the unique values.
    // Then delete the duplicate as soon as we detect it while walking the list.
    // Algorithm is O(n).
    var uniques = Set<Int>()
    var previous: Node? = nil
    var current = head

    while current != nil {
        if uniques.contains(current!.data) {
            previous!.next = current!.next // skip this duplicate
        } else {
            uniques.insert(current!.data)
            previous = current
        }
        current = current!.next
    }
}

let node3 = Node(3)
let node2 = Node(2, node3)
let node1 = Node(1, node2)
node3.next = Node(1)        // duplicate
printLinkedListSimple(node1)
print("===")
removeDuplictates(node1)
printLinkedListSimple(node1)

/**Subtree checker**/
class Node1 {
    var key: Int
    var left: Node1?
    var right: Node1?
    
    init(_ data: Int) {
        self.key = data
    }
}

func getOrder(_ root: Node1) -> String {
    var result = ""
    preOrderTraversal(root, &result);
    return result
}

func preOrderTraversal(_ node: Node1?, _ result: inout String) {
    guard let node = node else { return }
    result.append(String(node.key)) // root
    preOrderTraversal(node.left, &result)
    preOrderTraversal(node.right, &result)
}

let root = Node1(5)
root.left = Node1(3)
root.right = Node1(7)
root.left?.left = Node1(2)
root.left?.right = Node1(4)
root.right?.left = Node1(6)
root.right?.right = Node1(8)

let rootOrder = getOrder(root)  // 5324768
let subTree = Node1(7)
subTree.left = Node1(6)
subTree.right = Node1(8)

let subTreeOrder = getOrder(subTree)  // 768
func isSubTree(_ tree: Node1, _ subTree: Node1) -> Bool {
    let rootOrder = getOrder(root)  // 5324768
    let subTreeOrder = getOrder(subTree)  // 768
    return rootOrder.contains(subTreeOrder)
}

isSubTree(root, subTree)

/**Min stack**/
class MinStack {
    private class Node {
        var data: Int
        var min: Int // track here
        var next: Node?
        
        init(_ data: Int, _ min: Int, _ next: Node? = nil) {
            self.data = data
            self.min = min
            self.next = next
        }
    }
    
    private var head: Node?
    
    func push(_ data: Int) {
        var currentMin = data
        
        // Check for min with each push
        if head != nil {
            currentMin = Swift.min(data, min()!)
        }
                
        let newNode = Node(data, currentMin)
        newNode.next = head
        head = newNode
    }
    
    func pop() -> Int? {
        let data = head?.data
        head = head?.next
        return data
    }
    
    func min() -> Int? { return head?.min }
}

let stack = MinStack()

stack.push(5)
stack.push(6)
stack.push(3)
stack.push(7)
stack.min()       // 3
stack.pop()
stack.min()       // 3
stack.pop()
stack.min()       // 5

//__________________________________________________
func fizzBuzz() {
    for i in 1..<101 {
        if i % 3 == 0 && i % 5 == 0 {
            print("FizzBuzz")
        } else if i % 3 == 0 {
            print("Fizz")
        } else if i % 5 == 0 {
            print("Buzz")
        } else {
            print(i)
        }
    }
}

fizzBuzz()

//__________________________________________________
func isPalindrome(_ text: String) -> Bool {
    let chars = Array(text)
    let length = chars.count
    
    for i in 0..<length / 2 {
        if chars[i] != chars[length - i - 1] {
            return false
        }
    }
    return true
}

isPalindrome("abba")
isPalindrome("mom")
isPalindrome("dad")
isPalindrome("radar")
isPalindrome("rush")
isPalindrome("yes")

// If your interviewer is OK, you could also do this.
// But best to know above trick in case they want you to do manually.
func isPalindromeSimple(_ value: String) -> Bool {
    return value == String(value.reversed())
}

//____RansomNote______________________________________
func canWrite(note: String, letters: String) -> Bool {
    
    // Create a map of all values
    let noteMap = map(note.replacingOccurrences(of: " ", with: ""))
    let letterMap = map(letters)
    
    // Compare
    for (key, _) in noteMap {
        if letterMap[key] == nil {
            return false
        }

        let noteCount = noteMap[key]!
        let letterCount = letterMap[key]!

        if letterCount < noteCount {
            return false
        }
    }
    return true
}

func map(_ text: String) -> [Character: Int] {
    var map = [Character: Int]()
    let chars = Array(text)

    for char in chars {
        if map[char] != nil {
            map[char] = map[char]! + 1
        } else {
            map[char] = 1
        }
    }
    return map
}

canWrite(note: "Pay", letters: "yaP")
canWrite(note: "Pay", letters: "yaP a")
canWrite(note: "Pay me $1000", letters: "ayPem0001$")
canWrite(note: "Pay", letters: "Pa")

//__________________________________________________
class CaesarCipherSimple {
    private lazy var encryptMap: [Character: String] = {
        var map = [Character: String]()
        map["A"] = "X"
        map["B"] = "Y"
        map["C"] = "Z"
        map["D"] = "A"
        map["E"] = "B"
        map["F"] = "C"
        map["G"] = "D"
        map["H"] = "E"
        map["I"] = "F"
        map["J"] = "G"
        map["K"] = "H"
        map["L"] = "I"
        map["M"] = "J"
        map["N"] = "K"
        map["O"] = "L"
        map["P"] = "M"
        map["Q"] = "N"
        map["R"] = "O"
        map["S"] = "P"
        map["T"] = "Q"
        map["U"] = "R"
        map["V"] = "S"
        map["W"] = "T"
        map["X"] = "U"
        map["Y"] = "V"
        map["Z"] = "W"
        return map
    }()
    private lazy var decryptMap: [Character: String] = {
        var map = [Character: String]()
        map["X"] = "A"
        map["Y"] = "B"
        map["Z"] = "C"
        map["A"] = "D"
        map["B"] = "E"
        map["C"] = "F"
        map["D"] = "G"
        map["E"] = "H"
        map["F"] = "I"
        map["G"] = "J"
        map["H"] = "K"
        map["I"] = "L"
        map["J"] = "M"
        map["K"] = "N"
        map["L"] = "O"
        map["M"] = "P"
        map["N"] = "Q"
        map["O"] = "R"
        map["P"] = "S"
        map["Q"] = "T"
        map["R"] = "U"
        map["S"] = "V"
        map["T"] = "W"
        map["U"] = "X"
        map["V"] = "Y"
        map["W"] = "Z"
        return map
    }()

    func encrypt(_ plainText: String) -> String {
        var result = ""
        let chars = Array(plainText)
        
        for char in chars {
            var encryptedLetter = " "
            if char != " " {
                encryptedLetter = encryptMap[char]!
            }
            result.append(encryptedLetter)
        }
        return result
    }
    
    func decrypt(_ cipherText: String) -> String {
        var result = ""
        let chars = Array(cipherText)
        
        for char in chars {
            var decryptedLetter = " "
            if char != " " {
                decryptedLetter = decryptMap[char]!
            }
            result.append(decryptedLetter)
        }
        return result
    }

}

let cipher = CaesarCipherSimple()

cipher.encrypt("ABC")
cipher.encrypt("ATTACK AT FIRST LIGHT")
cipher.encrypt("MEET AT THE RUBICON")

cipher.decrypt("XYZ")
cipher.decrypt("XQQXZH XQ CFOPQ IFDEQ")
cipher.decrypt("JBBQ XQ QEB ORYFZLK")

class CaesarCipherAdvanced {
    
    let ALPHABET = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    
    func encrypt(_ plainText: String, _ n: Int = 3) -> String {
        var result = ""
        let charsToEncrypt = Array(plainText)
        let lookupMap = Array(ALPHABET)
        
        for charToEncrypt in charsToEncrypt {
            var encryptedChar: Character = " "
            if charToEncrypt != " " {
                let x = lookupMap.firstIndex(of: charToEncrypt)!
                let key = (n + x) % 26
                encryptedChar = lookupMap[key]
            }
            result.append(encryptedChar)
        }
        return result
    }
    
    func decrypt(_ cipherText: String, _ n: Int = 3) -> String {
        var result = ""
        let charsToDecrypt = Array(cipherText)
        let lookupMap = Array(ALPHABET)

        for charToDecrypt in charsToDecrypt {
            var decryptedChar: Character = " "
            if charToDecrypt != " " {
                let x = lookupMap.firstIndex(of: charToDecrypt)!
                let key = (x - n) % 26
                decryptedChar = lookupMap[key]
            }
            result.append(decryptedChar)
        }
        return result
    }
}

let cipherAdvanced = CaesarCipherAdvanced()

// Note: This algorithm shifts left (while the problem asks for right).
//       Keep it left to match solution in Wikipedia and make easier to follow.

cipherAdvanced.encrypt("ABC")
cipherAdvanced.encrypt("ATTACK AT FIRST LIGHT")
cipherAdvanced.encrypt("MEET AT THE RUBICON")

cipherAdvanced.decrypt("DEF")
cipherAdvanced.decrypt("DWWDFN DW ILUVW OLJKW")
cipherAdvanced.decrypt("PHHW DW WKH UXELFRQ")

//____StringReversal____________________________________
func reverse(_ text: String) -> String {
    var chars = Array(text)

    // Initialize pointers
    var left = 0
    var right = text.count - 1;

    // Loop through swapping left and right until we hit the middle
    for _ in 0..<text.count / 2 {
        let temp = chars[left]
        chars[left] = chars[right]
        chars[right] = temp
        left += 1
        right -= 1
    }

    return String(chars)
}

reverse("Hello")    // olleH
reverse("Sam")      // maS
reverse("It's been a long time.") // .emit gnol a neeb s'tI

String("Hello".reversed())

//____IntegerReversal_________________________________
func reverse2(_ x: Int) -> Int {
    var x = x
    let isNegative = x < 0
    
    if isNegative {
        x = abs(x)
    }
    
    var reverse2 = 0
    var lastDigit = 0
    
    while x >= 1 {
        lastDigit = x % 10 // get the last digit
        reverse2 = reverse2 * 10 + lastDigit  // shift by order of magnitude each time
        print("x: \(x) lastDigit: \(lastDigit) reverse: \(reverse2)")
        x = x / 10         // drop last digit
    }
    return isNegative ? reverse2 * -1 : reverse2
}

reverse2(123)    // 321
reverse2(-123)   // -321

//__________________________________________________
func isAnagram(_ text: String, _ anagram: String) -> Bool {
    let chars1 = Array(text).sorted()
    let chars2 = Array(anagram).sorted()
    
    return chars1 == chars2
}

isAnagram("arc", "car")         // true
isAnagram("night", "thing")     // true
isAnagram("cat", "dog")         // false

//= Go==================================================
func hasPairWithSumBrute(_ data: [Int], _ sum: Int) -> Bool {
    // progressively walk - O(n^2)
    for i in 0..<data.count {
        for j in i + 1..<data.count {
            if data[i] + data[j] == sum {
                return true
            }
        }
    }
    
    return false
}

hasPairWithSumBrute([1, 2, 4, 9], 8)     // false
hasPairWithSumBrute([1, 2, 4, 4], 8)     // true
hasPairWithSumBrute([1, 2, 4], 8)        // false

func hasPairWithSum(_ data: [Int], _ sum: Int) -> Bool {
    
    // Store the complement in a Set
    var comp = Set<Int>()
    
    for value in data { // O(n)
        // And then add it if we haven't seen it
        print("Have we seen \(value)'s complement \(sum - value) before?")
        if comp.contains(value) {
            print("Yes we have - match ✅.")
            return true
        }
        print("No we have not. Add it.")
        comp.insert(sum - value)
    }
    return false
}

//hasPairWithSum([1, 2, 4, 9], 8)     // false
hasPairWithSum([1, 2, 4, 4], 8)     // true
//hasPairWithSum([1, 2, 4], 8)        // false

//= FB =================================================
//#1
func intersectBrute(_ A: [Int], _ B: [Int]) -> [Int] {
    var result = [Int]()
    // O(n)
    for a in A {
        // O(m)
        for b in B {
            if a == b {
                result.append(a)
            }
        }
    }
    return result
}

intersectBrute([1, 2, 4, 5, 6], [2, 3, 5, 7]) // [2, 5]

func intersect(_ A: [Int], _ B: [Int]) -> [Int] {
    
    // create two pointers and loop through both arrays
    // if one element is less than the other...
    //   increment the lower pointer
    // if elements are equal collect
    // then increment either of the pointers
    
    var result = [Int]()
    
    var i = 0; let m = A.count
    var j = 0; let n = B.count
    
    // O(n + m)
    while i < m && j < n {
        if A[i] < B[j] {
            i += 1
        } else if B[j] < A[i] {
            j += 1
        } else {
            result.append(A[i])
            i += 1
        }
    }
    
    return result
}

intersect([1, 2, 4, 5, 6], [2, 3, 5, 7]) // [2, 5]

//#BinaryTree
class Node3 {
    var data: Int
    var left: Node3?
    var right: Node3?
    
    init(_ data: Int) {
        self.data = data
    }
    
    func copy() -> Node3 {
        let newNode = Node3(data)
        if let left = left {
            newNode.left = left.copy()
        }
        if let right = right {
            newNode.right = right.copy()
        }
        return newNode
    }
    
    func inOrderTraversal(node: Node3?) {
        // L
        // Root
        // R
        guard let node = node else { return }
        inOrderTraversal(node: node.left) // L
        print(node.data) // root          // Root
        inOrderTraversal(node: node.right)// R
    }
}

class Tests: XCTestCase {

    func testCopy() {
        //          1
        //         / \
        //        2   3
        let node1 = Node3(1)
        let node2 = Node3(2)
        let node3 = Node3(3)
        node1.left = node2
        node1.right = node3
        
        let newCopy = node1.copy()
        XCTAssertEqual(newCopy.data, node1.data)
        XCTAssertEqual(newCopy.left!.data, node1.left!.data)
        XCTAssertEqual(newCopy.right!.data, node1.right!.data)
        
        // print nodes inorder traversal
        newCopy.inOrderTraversal(node: newCopy)
    }
    
    func testDeepCopy() {
        //          5
        //         / \
        //        3   7
        //       / \  /\
        //      2  4 6  8
        let node5 = Node3(5)
        let node3 = Node3(3)
        let node7 = Node3(7)
        let node2 = Node3(2)
        let node4 = Node3(4)
        let node6 = Node3(6)
        let node8 = Node3(8)
        
        node5.left = node3
        node5.right = node7
        
        node3.left = node2
        node3.right = node4
        
        node7.left = node6
        node7.right = node8
        
        let newCopy = node5.copy()
        XCTAssertEqual(newCopy.data, node5.data)
        XCTAssertEqual(newCopy.left!.data, node5.left!.data)
        XCTAssertEqual(newCopy.right!.data, node5.right!.data)
        
        // Modify 7 to point to 9 instead of 8
        let node9 = Node3(9)
        node7.right = node9
        
        // Copy should still point to old value - 8
        XCTAssertEqual(newCopy.right!.right!.data, 8)
        
        // print nodes inorder traversal
        newCopy.inOrderTraversal(node: newCopy)
    }
}

// Infrastructure
class TestObserver: NSObject, XCTestObservation {
    func testCase(_ testCase: XCTestCase,
                  didFailWithDescription description: String,
                  inFile filePath: String?,
                  atLine lineNumber: Int) {
        assertionFailure(description, line: UInt(lineNumber))
    }
}
let testObserver = TestObserver()
XCTestObservationCenter.shared.addTestObserver(testObserver)
Tests.defaultTestSuite.run()

//= Azone ================================================
/*An algorithm that merges these two arrays into one*/
func merge(_ L1: [Int], _ L2: [Int]) -> [Int] {
    var result = [Int]()
    
    var i = 0
    var j = 0
    
    // Merge the full length of on list
    while i < L1.count && j < L2.count {
        if L1[i] <= L2[j] {
            result.append(L1[i])
            i += 1
        } else {
            result.append(L2[j])
            j += 1
        }
    }
    
    // Copy remaining elements of L1
    while i < L1.count {
        result.append(L1[i])
        i += 1
    }

    // Copy remaining elements of L2
    while j < L2.count {
        result.append(L2[j])
        j += 1
    }

    return result
}



class Tests2: XCTestCase {

    func testMerge() {
        let expected = [1, 2, 3, 5, 5, 7, 8, 11, 14]
        let actual = merge([1, 3, 5, 7], [2, 5, 8, 11, 14])
        XCTAssertEqual(expected, actual)
    }
 
    func testL1Empty() {
        let expected = [2, 5, 8, 11, 14]
        let actual = merge([], [2, 5, 8, 11, 14])
        XCTAssertEqual(expected, actual)
    }
    
    func testL2Empty() {
        let expected = [1, 3, 5, 7]
        let actual = merge([1, 3, 5, 7], [])
        XCTAssertEqual(expected, actual)
    }

    func testNoOverlap() {
        let expected = [1, 2, 3, 4, 5, 6]
        let actual = merge([1, 2, 3], [4, 5, 6])
        XCTAssertEqual(expected, actual)
    }
}

// Infrastructure
class TestObserver2: NSObject, XCTestObservation {
    func testCase(_ testCase: XCTestCase,
                  didFailWithDescription description: String,
                  inFile filePath: String?,
                  atLine lineNumber: Int) {
        assertionFailure(description, line: UInt(lineNumber))
    }
}
let testObserver2 = TestObserver2()
XCTestObservationCenter.shared.addTestObserver(testObserver)
Tests.defaultTestSuite.run()

//= Spot ================================================
