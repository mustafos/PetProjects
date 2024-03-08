import Foundation
import UIKit

class Node {
    var data: Int
    var next: Node?
    
    init(_ data: Int, _ next: Node? = nil) {
        self.data = data
        self.next = next
    }
}

class LinkList {
    private var head: Node?
    
    func addFront(_ data: Int) {
        let newNode = Node(data)
        newNode.next = head
        head = newNode
    }
    
    func getFirst() -> Int? {
        if head == nil {
            return nil
        }
        return head!.data
    }
        
    func addBack(_ data: Int) {
        let newNode = Node(data)
        
        if head == nil {
            head = newNode
            return
        }

        var node = head!
        while(node.next != nil) {
            node = node.next!
        }
        node.next = newNode
    }

    func getLast() -> Int? {
        if head == nil {
            return nil
        }

        var node = head!
        while(node.next != nil) {
            node = node.next!
        }
        return node.data
    }

    func insert(position: Int, data: Int) {
        if position == 0 {
            addFront(data)
            return
        }
            
        let newNode = Node(data)
        var currentNode = head

        for _ in 0..<position - 1{
            currentNode = currentNode?.next!
        }
        newNode.next = currentNode?.next
        currentNode?.next = newNode
    }
    
    func deleteFirst() {
        head = head?.next
    }
    
    func delete(at position: Int) {
        if position == 0 {
            self.deleteFirst()
            return
        }
        
        var nextNode = head
        var previousNode: Node?
        for _ in 0..<position {
            previousNode = nextNode
            nextNode = nextNode?.next
        }
        previousNode?.next = nextNode?.next
    }

    func deleteLast() {
        if head?.next == nil {
            head = nil
            return
        }

        var nextNode = head
        var previousNode: Node?
        while(nextNode?.next != nil) {
            previousNode = nextNode
            nextNode = nextNode?.next
        }
        previousNode?.next = nil
    }
    
    func delete(data: Int) {
        if head == nil { return }
        if head!.data == data {
            head = head?.next
        }
        
        let current = head
        while current?.next != nil {
            if current?.next?.data == data {
                current?.next = current?.next?.next
                return
            }
        }
    }

    var isEmpty: Bool {
        return head == nil
    }
    
    func clear() {
        head = nil
    }

    func printLinkedList() {
        if head == nil {
            print("Empty")
            return
        }
        
        var result = [Int]()
        var node = head
        result.append(node!.data)
        
        while node?.next != nil {
            result.append(node!.next!.data)
            node = node?.next
        }
        
        print(result)
    }
}

let linkedList = LinkList()
linkedList.addFront(3)
linkedList.addFront(2)
linkedList.addFront(1)
linkedList.printLinkedList()

linkedList.getFirst()

linkedList.addBack(4)
linkedList.printLinkedList()

linkedList.getLast()

linkedList.insert(position: 2, data: 5)
linkedList.printLinkedList()

linkedList.deleteFirst()
linkedList.printLinkedList()

linkedList.deleteLast()
linkedList.printLinkedList()

linkedList.delete(at: 1)
linkedList.printLinkedList()

linkedList.deleteLast()
linkedList.printLinkedList()

linkedList.deleteLast()
linkedList.printLinkedList()

//__________________________________________________________
//Length of linked list

func length(_ head: Node?) -> Int {
    if head == nil {
        return 0
    }
    
    var len = 0
    var current = head
    while current != nil {
        len += 1
        current = current?.next
    }
    return len
}

// 1 2 3 4 5 6
let node6 = Node(6)
let node5 = Node(5, node6)
let node4 = Node(4, node5)
let node3 = Node(3, node4)
let node2 = Node(2, node3)
let node1 = Node(1, node2)

length(nil)
length(node1)

//__________________________________________________________
//Find Merge Point of Two Lists
/*
 Given pointers to the head nodes of 2 linked lists that merge together at some point, find the node where the two lists merge. The merge point is where both lists point to the same node, i.e. they reference the same memory location. It is guaranteed that the two head nodes will be different, and neither will be NULL. If the lists share a common node, return that node's data value.

 Note: After the merge point, both lists will share the same node pointers.
 
 */

func printLinkedList(_ head: Node?) {
    if head == nil { return }
    
    var result = [Int]()
    var node = head
    result.append(node!.data)
    
    while node?.next != nil {
        result.append(node!.next!.data)
        node = node?.next
    }
    
    print(result)
}

// Loop through every element of A while checking every element of B
func findMergeBrute(headA: Node?, headB: Node?) -> Int? { // O(m*n)
    let m = length(headA) // O(m)
    let n = length(headB) // O(n)
    
    var currentA = headA
    
    for _ in 0...m-1 { // O(m)
        var currentB = headB
        for _ in 0...n-1 { // O(n)
            let A = currentA?.data
            let B = currentB?.data
            print("A: \(A ?? 0) B: \(B ?? 0)")
            if A == B {
                return currentA?.data
            }
            currentB = currentB?.next
        }
        currentA = currentA?.next
    }
    return nil
}

// Trade-off time for space
func findMergeSpaceTime(headA: Node?, headB: Node?) -> Int? { // O(2m + 2n) > O(m + n)
    // Create a Dict of all nodes of B
    // Use it to loop up each element of A
    let m = length(headA) // O(m)
    let n = length(headB) // O(n)

    var dict = [Int?: Bool]()
    var currentB = headB
    for _ in 0...n-1 { // O(n)
        let B = currentB?.data
        dict[B] = true
        currentB = currentB?.next
    }
    
    var currentA = headA
    for _ in 0...m-1 { // O(m)
        let A = currentA?.data
        if dict[A] == true {
            return A
        }
        currentA = currentA?.next
    }
    return nil
}

// Insight: If we can line up the arrays, we can walk them once
func findMergeInsight(headA: Node?, headB: Node?) -> Int? { // O(n + m)
    // Figure out which is longer
    // Swap if necessary
    
    // Calculate d
    // Walk d for longer
    // Walk remainder for both
    let m = length(headA) // O(m)
    let n = length(headB) // O(n)

    var currentA = headA
    var currentB = headB
    
    if n > m {
        let temp = currentA
        currentA = currentB
        currentB = temp
    }
    
    let d = abs(m - n)

    for _ in 1...d { // O(n)
        currentA = currentA?.next
    }
    
    for _ in 0...n-1 { // O(n)
        print(4)
        let A = currentA?.data
        let B = currentB?.data
        if A == B {
            return A
        }
        currentA = currentA?.next
        currentB = currentB?.next
    }
    return nil
}

//Detect A Cycle_________________________________________
/*A linked list is said to contain a cycle if any node is visited more than once while traversing the list. For example, in the following graph there is a cycle formed when node 5 points back to node 3.
 
        4
      /   \
 1 2 3      5
     \_____/
 */

func hasCycle(first: Node) -> Bool {
    var slow: Node? = first
    var fast: Node? = first
    
    while fast != nil && fast!.next != nil {
        slow = slow?.next
        fast = fast?.next?.next
        
        if slow?.data == fast?.data {
            return true
        }
    }
    return false
}

let head5 = Node(5)
let head4 = Node(4)
let head3 = Node(3)
let head2 = Node(2)
let head = Node(1)

head.next = head2
head2.next = head3
head3.next =  head4
head4.next = head5
head5.next = head3

hasCycle(first: head)
