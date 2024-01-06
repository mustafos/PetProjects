import UIKit

/**Last-in first-out (LIFO) Push and pop are O(1) operations.*/

class Stack<T> {
    private var array: [T] = []
    
    func push(_ item: T) {
        array.append(item)
    }
    
    func pop() -> T? {
        array.popLast()
    }
    
    func peek() -> T? {
        array.last
    }
    
    var isEmpty: Bool {
        array.isEmpty
    }
    
    var count: Int {
        array.count
    }
}

struct StackStruct<T> {
    fileprivate var array = [T]()
    
    mutating func push(_ item: T) {
        array.append(item)
    }
    
    mutating func pop() -> T? {
        array.popLast()
    }
    
    var peek: T? {
        array.last
    }
    
    var isEmpty: Bool {
        array.isEmpty
    }
    
    var count: Int {
        array.count
    }
}

/**First-in first-out (FIFO) enqueue O(1) dequeue O(n)*/
class Queue<T> {
    private var array: [T] = []
    
    func enqueue(_ item: T) {
        array.append(item)
    }
    
    func dequeue() -> T? {
        if isEmpty {
            return nil
        } else {
            return array.removeFirst()
        }
    }
    
    var isEmpty: Bool {
        return array.isEmpty
    }
    
    var count: Int {
        return array.count
    }
    
    func peek() -> T? {
        return array.first
    }
}

struct QueueStruct<T> {
    private var array: [T] = []
    
    mutating func enqueue(_ item: T) {
        array.append(item)
    }
    
    mutating func dequeue() -> T? {
        if isEmpty {
            return nil
        } else {
            return array.removeFirst()
        }
    }
    
    var isEmpty: Bool {
        return array.isEmpty
    }
    
    var count: Int {
        return array.count
    }
    
    func peek() -> T? {
        return array.first
    }
}
//________________________________________________________
/*
 Rotate array to right N times.
 https://app.codility.com/programmers/lessons/2-arrays/cyclic_rotation/
 
 For example, given

     A = [3, 8, 9, 7, 6]
     K = 3
 the function should return [9, 7, 6, 3, 8]. Three rotations were made:

     [3, 8, 9, 7, 6] -> [6, 3, 8, 9, 7]
     [6, 3, 8, 9, 7] -> [7, 6, 3, 8, 9]
     [7, 6, 3, 8, 9] -> [9, 7, 6, 3, 8]
 
 Shoot for correctness. Not performance.
 */

func solutionQueueRight(A: [Int], K: Int) -> [Int] {
    guard !A.isEmpty else { return [] }
    guard K > 0 else { return A }

    var result = A

    // treat like a queue enqueuing and dequeuing off the end
    for _ in 1...K {
        let last = result.last!
        result.insert(last, at: 0)
        result.remove(at: A.count)
    }

    return result
}

solutionQueueRight(A: [1, 2, 3, 4, 5], K: 1) // [5, 1, 2, 3, 4]
solutionQueueRight(A: [1, 2, 3, 4, 5], K: 2) // [4, 5, 1, 2, 3]
solutionQueueRight(A: [1, 2, 3, 4, 5], K: 3) // [3, 4, 5, 1, 2]

solutionQueueRight(A: [3, 8, 9, 7, 6], K: 3) // [9, 7, 6, 3, 8]

/*
 Rotate array to right N times.
 https://app.codility.com/programmers/lessons/2-arrays/cyclic_rotation/
 
 For example, given

     A = [3, 8, 9, 7, 6]
     K = 3
 the function should return [9, 7, 6, 3, 8]. Three rotations were made:

     [3, 8, 9, 7, 6] -> [6, 3, 8, 9, 7]
     [6, 3, 8, 9, 7] -> [7, 6, 3, 8, 9]
     [7, 6, 3, 8, 9] -> [9, 7, 6, 3, 8]

 Shoot for correctness. Not performance.
 */

func solutionQueueLeft(A: [Int], K: Int) -> [Int] {
    guard !A.isEmpty else { return [] }
    guard K > 0 else { return A }
    
    var result = A
    
    // treat like a queue enqueuing and dequeuing off the end
    for _ in 1...K {
        let first = result.first!
        result.append(first)
        result.remove(at: 0)
    }
    
    return result
}

solutionQueueLeft(A: [1, 2, 3, 4, 5], K: 1) // [2, 3, 4, 5, 1]
solutionQueueLeft(A: [1, 2, 3, 4, 5], K: 2) // [3, 4, 5, 1, 2]
solutionQueueLeft(A: [1, 2, 3, 4, 5], K: 3) // [4, 5, 1, 2, 3]

solutionQueueLeft(A: [3, 8, 9, 7, 6], K: 3) // [7, 6, 3, 8, 9]


//_________________________________________________________
/* Giving a String, write a function that reverses the String using a stack. */

func solution(_ text: String) -> String {
    var chars = Array(text)
    
    // Create stack
    var result = [String]()
    
    // Push chars
    for c in chars {
        result.append(String(c))
    }
    
    // Pop chars
    for i in 0..<result.count {
        chars[i] = Character(result.popLast()!)
    }
    
    return String(chars)
}

solution("abc") // bca
solution("Would you like to play a game?")

//_______________________________________________________
/*
 Balanced brackets
 https://www.hackerrank.com/challenges/balanced-brackets/problem
 
 A bracket is considered to be any one of the following characters: (, ), {, }, [, or ].

 Two brackets are considered to be a matched pair if the an opening bracket (i.e., (, [, or {) occurs to the left of a closing bracket (i.e., ), ], or }) of the exact same type. There are three types of matched pairs of brackets: [], {}, and ().

 A matching pair of brackets is not balanced if the set of brackets it encloses are not matched. For example, {[(])} is not balanced because the contents in between { and } are not balanced. The pair of square brackets encloses a single, unbalanced opening bracket, (, and the pair of parentheses encloses a single, unbalanced closing square bracket, ].

 By this logic, we say a sequence of brackets is balanced if the following conditions are met:

 It contains no unmatched brackets.
 The subset of brackets enclosed within the confines of a matched pair of brackets is also a matched pair of brackets.
 Given  strings of brackets, determine whether each sequence of brackets is balanced. If a string is balanced, return YES. Otherwise, return NO.
 */
func isBalanced(s: String) -> String {

    var st = [Character]()
    
    for c in s {
        switch c {
        case "{", "(", "[":
            st.append(c)
        case "}":
            if (st.isEmpty || (st.last != "{")) {
                return "NO"
            }
            st.popLast()
        case ")":
            if (st.isEmpty || (st.last != "(")) {
                return "NO";
            }
            st.popLast()
        case "]":
            if (st.isEmpty || (st.last != "[")) {
                return "NO";
            }
            st.popLast()
        default:
            print("breaking \(c)")
        }
    }
    
    return st.isEmpty ? "YES" : "NO"
}

isBalanced(s: "{[()]}") // Yes
isBalanced(s: "[()]}") // No
isBalanced(s: "{}()(){}((){})({[[({({(){}{}}){}})]{({()}((())))}()]})(({}(()){[][]}){()}(({}{}))())()[](){{((){})}}()([[]])[][]()({}((([()]{})())[][[()]]())){{}}[]{()}()[][]{}([])[]{({})}{}{{}{[[]]}[]{}}{[()]}[]{(([{{[{[]}]}[{}]}]))}(){}{{}}[]((([])([{(){}[(()[]((()(){})({([]({{{[]{}}[({})()({}{([()])()()[]{}})][{[]}]{{}([]({{{(()(({}[[[{{}}]]{{[()]([[{{}([[]][([{{}}(([])[][({()}())()({}[])]{}[])]())[]]){}}[]]])([]({{[[][]{[]}[]]}}{}(){[]}))}()[]((){{}()[{[[()]]}()]}[()]{})}][]{}))())}(())}{{[]}{}}({[([{[{[[[]]]{()}[]}]{}}()((({{{{({{(){}}}[[()]()[]]())({{{[]}{{[[{{[{}]}}[][]]]([][](()(()[]){{}}))([])}}}}[{}{}])[(){{()()}{(())}()}]{(){{}[]{}[][{[]([[]()]{(){[{}[()]][{}{}]{(){}}}{[]}}{[]}[]){[]}[]}][((){}{}[[[[{{}()[([({{[[][{{()}(([[]][[[[[[[{}]][{}]]]()](())[()[][]({({[][][[]{}][]}{})}{({})([[][]({}{[]})])[([([])][[]{([])(({}))}](()[]){[[]]}({}))]}[])()]]]))([{}()()([([[{}][()]][])])][[[{}][][]({[]})][(({{()}}))]])}]]}})])]}]]]])]}}}}}})))])]})}))}}}))})))]}])))") // Yes
