import Foundation
import UIKit

struct Person {}

let ints = [1, 2, 3]
let strings = ["a", "b", "c"]
let people = [Person(), Person(), Person()]

let arrayOfSpecificSize = Array<Int>(repeating: 1, count: 10)

var array = ["a", "b", "c", "d"]
array.remove(at: 1)
array.insert("b", at: 1)
array.append("e")

//CyclicRotation__https://app.codility.com/programmers/ __
/**An array A consisting of N integers is given. Rotation of the array means that each element is shifted right by one index, and the last element of the array is moved to the first place. For example, the rotation of array A = [3, 8, 9, 7, 6] is [6, 3, 8, 9, 7]**/
func solution(A: [Int], K: Int) -> [Int] {
    guard !A.isEmpty else { return [] }
    guard K > 0 else { return A }
    
    var result = A
    for _ in 1...K { // O(n)
        result = rotateRightOnce(A: result)
    }
    return result
}

func rotateRightOnce(A: [Int]) -> [Int] {
    var newArray = Array<Int>(repeating: 0, count: A.count)
    for i in 0..<A.count - 1 { // O(n)
        newArray[i + 1] = A[i]
    }
    newArray[0] = A.last!
    
    return newArray
}

rotateRightOnce(A: [1, 2, 3])

solution(A: [1, 2, 3], K: 4)

solution(A: [1, 2, 3, 4, 5], K: 1)
solution(A: [1, 2, 3, 4, 5], K: 2)
solution(A: [1, 2, 3, 4, 5], K: 3)

solution(A: [3, 8, 9, 7, 6], K: 3) // [9, 7, 6, 3, 8]
/*
 Using a stack
 */

func solutionStackRight(A: [Int], K: Int) -> [Int] {
    guard !A.isEmpty else { return [] }
    guard K > 0 else { return A }

    var result = A

    // treat like a stack and pop off first and add to end
    for _ in 1...K {
        let last = result.last! // O(1)
        result.insert(last, at: 0) // O(n)
        result.remove(at: A.count) // O(n)
    }

    return result
}

solutionStackRight(A: [1, 2, 3, 4, 5], K: 1)
solutionStackRight(A: [1, 2, 3, 4, 5], K: 2)
solutionStackRight(A: [1, 2, 3, 4, 5], K: 3)
solutionStackRight(A: [1, 2, 3, 4, 5], K: 4)

func solutionStackLeft(A: [Int], K: Int) -> [Int] {
    guard !A.isEmpty else { return [] }
    guard K > 0 else { return A }
    
    var result = A
    
    // treat like a stack and pop off first and add to end
    for _ in 1...K {
        let first = result.first!
        result.append(first)
        result.remove(at: 0)
    }
    
    return result
}

solutionStackLeft(A: [1, 2, 3, 4, 5], K: 1)
solutionStackLeft(A: [1, 2, 3, 4, 5], K: 4)

//DashPhoneNumber_________________________________________
/**We are given a string S representing a phone number, which we would like to reformat. String S consists of N characters: digits, spaces, and/or dashes. It contains at least two digits. Spaces and dashes in string S can be ignored. We want to reformat the given phone number is such a way that the digits are grouped in blocks of length three, separated by single dashes. If necessary, the final block or the last two blocks can be of length two.**/
 
func solution(_ S : String) -> String {
    
    // removing spaces and dashes
    let noSpace = S.replacingOccurrences(of: " ", with: "")
    let noSpaceNoDash = noSpace.replacingOccurrences(of: "-", with: "")
        
    // loop through char-by-char appending dashes
    var result = ""
    
    var count = -2
    for c in noSpaceNoDash {
        result.append(c)
        if count % 3 == 0 {
            result.append("-")
        }
        count += 1
    }
    
    // strip off lingering dash
    if result.last == "-" {
        result = String(result.dropLast())
    }
    
    // if second last char has a dash (-x)
    // reformat last three chars to (-xx)
    var chars = Array(result)
    let secondLastPtr = chars.count - 2
    if chars[secondLastPtr] == "-" {
        // *-x > -*x
        chars[secondLastPtr] = chars[secondLastPtr - 1]
        chars[secondLastPtr - 1] = "-"
    }

    return String(chars)
}

solution("123456789")           // 123-456-789
solution("555372654")           // 555-372-654
solution("0 - 22 1985--324")    // 022-198-53-24
// Edge cases
solution("01")                          // 01
solution("012")                         // 012
solution("0123")                        // 01-23
solution("0123       444")              // 012-34-44


// ContactMatch_________________________________________
/**When someone searches their contacts based on a phone number, it's nice when a list
 of contact pops up. Write an algorithm that searches you contacts for phone number strings, and returns:
  - NO CONTACT if contact can't be found
  - A contact if a contact is found
  - The first alphabetized contact if there are multiple**/

public func solution(_ A : [String], _ B : [String], _ P : String) -> String {
    var result = [String]()
    
    // loop through looking for match - when found add to result
    for i in 0..<B.count {
        if B[i].contains(P) {
            result.append(A[i])
        }
    }
    
    if result.count == 0 {
        return "NO CONTACT"
    } else if result.count == 1 {
        return result.first!
    }
    
    // sort and return first
    return result.sorted().first!
}

let A = ["pim", "pom"]
let B = ["999999999", "777888999"]
let P = "88999"

solution(A, B, P)   // pom
solution(["sander", "amy", "ann"], ["12345", "23456", "123"], "1")  // ann
solution(["ada,", "eva", "leo"], ["1212", "1111", "4444"], "112")   // NO CONTACT

// edge cases
solution([String](), [String](), "")
solution(A, B, "")

public func solutionDict(_ A : [String], _ B : [String], _ P : String) -> String {

    // Create a dictionary of name / numbers
    var dict = [String: String]()
    
    for i in 0..<A.count {
        dict[A[i]] = B[i]
    }
    
    // look for matches
    let matches = dict.filter { $0.value.contains(P) }
    
    if matches.count == 0 {
        return "NO CONTACT"
    } else if matches.count == 1 {
        return matches.first!.key
    }
    
    // sort by key
    let sortedKeys = matches.keys.sorted()
    
    return sortedKeys.first!
}


