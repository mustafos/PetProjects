import Foundation
import XCTest

class Node {
    var key: Int = 0
    var left: Node?
    var right: Node?
    
    init(_ key: Int) {
        self.key = key
    }
    
    var min: Node {
        if left == nil {
            return self
        } else {
            return left!.min
        }
    }
}

class BST {
    var root: Node?

    func insert(key: Int) {
        root = insertItem(root, key)
    }
    
    private func insertItem(_ node: Node?, _ key: Int) -> Node {
        
        // If node is nil - set it here. We are done.
        guard let node = node else {
            let node = Node(key)
            return node
        }
        
        if key < node.key {
            node.left = insertItem(node.left, key)
        }
        if key > node.key {
            node.right = insertItem(node.right, key)
        }
        
        // If we get here we have have hit the bottom of our tree with a duplicate.
        // Since duplicates are not allowed in BSTs, simply ignore the duplicate,
        // and return our fully constructed tree. We are done!
        return node;
    }
    
    func find(key: Int) -> Int? {
        guard let root = root else { return nil }
        guard let node = find(root, key) else { return nil }
        
        return node.key
    }

    private func find(_ node: Node?, _ key: Int) -> Node? {
        guard let node = node else { return nil }
        
        if node.key == key {
            return node
        } else if key < node.key {
            return find(node.left, key)
        } else if key > node.key {
            return find(node.right, key)
        }
        return nil
        // Note: duplicate keys not allowed so don't need to check
    }
    
    func findMin() -> Int {
        guard let root = root else { return 0 }
        return findMin(root).key;
    }

    private func findMin(_ node: Node) -> Node {
        return node.min;
    }

    // Delete: Three cases
    // 1. No child
    // 2. One child
    // 3. Two children

    // First two are simple. Third is more complex.

    // Case 1: No child - simply remove from tree by nulling it.
    //
    // Case 2: One child - copy the child to the node to be deleted and delete the child

    // Case 3: Two children - re-gig the tree to turn into a Case 1 or a Case 2

    // For third case we first need to
    // 1. Find the right side min
    // 2. Copy it to the node we want to delete (creating a duplicate)
    // 3. Then delete the min value way down on the branch we just copied
    //
    // This works because you can represent a binary tree in more than one way.
    // Here we are taking advantage of that fact to make our more complicated
    // 3rd case delete more simple by transforming it into case 1.


    func delete(key: Int) {
        guard let _ = root else { return }
        root = delete(&root, key);
    }
    
    private func delete(_  node: inout Node?, _ key: Int) -> Node? {
        guard let nd = node else { return nil }

        if key < nd.key {
            nd.left = delete(&nd.left, key)
        } else if key > nd.key {
            nd.right = delete(&nd.right, key)
        } else {
            // Woohoo! Found you. This is the node we want to delete.

            // Case 1: No child
            if nd.left == nil && nd.right == nil {
                return nil
            }
            
            // Case 2: One child
            else if nd.left == nil {
                return nd.right // check delete(&insideNode.right, key) not necessary because we have already found
            }
            else if nd.right == nil {
                return nd.left // delete(&insideNode.left, key)
            }
            
            // Case 3: Two children
            else {
                // Find the minimum node on the right (could also find max on the left)
                let minRight = findMin(nd.right!)
                
                // Duplicate it by copying its value here
                nd.key = minRight.key
                
                // Now go ahead and delete the node we just duplicated (same key)
                nd.right = delete(&nd.right, nd.key)
            }
        }
        
        return nd
    }

    func prettyPrint() {
        // Hard code print for tree depth = 3
        let rootLeftKey = root?.left == nil ? 0 : root?.left?.key
        let rootRightKey = root?.right == nil ? 0 : root?.right?.key
        
        var rootLeftLeftKey = 0
        var rootLeftRightKey = 0
        
        if root?.left != nil {
            rootLeftLeftKey = root?.left?.left == nil ? 0 : root?.left?.left?.key as! Int
            rootLeftRightKey = root?.left?.right == nil ? 0 : root?.left?.right?.key as! Int
        }
        
        var rootRightLeftKey = 0
        var rootRightRightKey = 0
        
        if root?.right != nil {
            rootRightLeftKey = root?.right?.left == nil ? 0 : root?.right?.left?.key as! Int
            rootRightRightKey = root?.right?.right == nil ? 0 : root?.right?.right?.key as! Int
        }
     
        let str = """
                      \(root!.key)
                    /  \\
                   \(rootLeftKey!)    \(rootRightKey!)
                  / \\  / \\
                 \(rootLeftLeftKey)  \(rootLeftRightKey) \(rootRightLeftKey)   \(rootRightRightKey)
        """

        print(str)
    }
    
    /*
            1
           / \
          2   3
     
     Three ways to walk depth first:
     - inorder (L > Root > R) 213 Good if there is inherit order smallest > largest (Left > Right)
     - preorder (Root > L > R) 123 Good for copying and expression tress (Top > Bottom)
     - postorder (L > R > Root) 231 Bottom up used in deletes (Bottom > Up)
     
     */
    
    func printInOrderTravseral() { inOrderTraversal(node: root) }
    
    func inOrderTraversal(node: Node?) {
        guard let node = node else { return }
        inOrderTraversal(node: node.left)
        print(node.key) // root
        inOrderTraversal(node: node.right)
    }
    
    func printPreOrderTravseral() { preOrderTraversal(node: root) }
    
    func preOrderTraversal(node: Node?) {
        guard let node = node else { return }
        print(node.key) // root
        preOrderTraversal(node: node.left)
        preOrderTraversal(node: node.right)
    }

    func printPostOrderTravseral() { postOrderTraversal(node: root) }
    
    func postOrderTraversal(node: Node?) {
        guard let node = node else { return }
        postOrderTraversal(node: node.left)
        postOrderTraversal(node: node.right)
        print(node.key) // root
    }
}

class BSTTests: XCTestCase {
    var bst: BST!
    override func setUp() {
        super.setUp()
        bst = BST()
    }
    
    func testInsert() {
        bst.insert(key: 5)
        bst.insert(key: 3)
        bst.insert(key: 2)
        bst.insert(key: 4)
        bst.insert(key: 7)
        bst.insert(key: 6)
        bst.insert(key: 8)

        bst.prettyPrint()

        XCTAssertNotNil(bst.find(key: 5))
        XCTAssertNotNil(bst.find(key: 3))
        XCTAssertNotNil(bst.find(key: 2))
        XCTAssertNotNil(bst.find(key: 4))
        XCTAssertNotNil(bst.find(key: 7))
        XCTAssertNotNil(bst.find(key: 6))
        XCTAssertNotNil(bst.find(key: 8))
    }

    func testDeleteNoChild() {
        bst.insert(key: 5)
        bst.insert(key: 3)
        bst.insert(key: 2)
        bst.insert(key: 4)
        bst.insert(key: 7)
        bst.insert(key: 6)
        bst.insert(key: 8)

        XCTAssertNotNil(bst.find(key: 2))
        bst.delete(key: 2)
        XCTAssertNil(bst.find(key: 2))

        XCTAssertNotNil(bst.find(key: 5))
        XCTAssertNotNil(bst.find(key: 3))
        XCTAssertNotNil(bst.find(key: 4))
        XCTAssertNotNil(bst.find(key: 7))
        XCTAssertNotNil(bst.find(key: 6))
        XCTAssertNotNil(bst.find(key: 8))
    }

    func testDeleteOneChild() {
        bst.insert(key: 5)
        bst.insert(key: 3)
        bst.insert(key: 2)
        bst.insert(key: 4)
        bst.insert(key: 7)
        bst.insert(key: 6)
//        bst.insert(key: 8)

        XCTAssertNotNil(bst.find(key: 2))
        bst.delete(key: 7)
        XCTAssertNil(bst.find(key: 7))

        XCTAssertNotNil(bst.find(key: 5))
        XCTAssertNotNil(bst.find(key: 3))
        XCTAssertNotNil(bst.find(key: 4))
        XCTAssertNotNil(bst.find(key: 6))
    }

    func testDeleteTwoChildren() {
        bst.insert(key: 5)
        bst.insert(key: 3)
        bst.insert(key: 2)
        bst.insert(key: 4)
        bst.insert(key: 7)
        bst.insert(key: 6)
        bst.insert(key: 8)

        XCTAssertNotNil(bst.find(key: 2))
        bst.delete(key: 7)
        XCTAssertNil(bst.find(key: 7))

        XCTAssertNotNil(bst.find(key: 5))
        XCTAssertNotNil(bst.find(key: 3))
        XCTAssertNotNil(bst.find(key: 4))
        XCTAssertNotNil(bst.find(key: 6))
        XCTAssertNotNil(bst.find(key: 8))
    }
}


// Infrastructure for running unit tests

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
BSTTests.defaultTestSuite.run()

//_______________________________________________________________________
/*
 CheckBST
 https://www.hackerrank.com/challenges/ctci-is-binary-search-tree/problem
 
 Given the root node of a binary tree, determine if it is a binary search tree.
 
 The Node class is defined as follows:
    class Node {
        int data;
        Node left;
        Node right;
     }
*/

func checkBST(root: Node?) -> Bool {
    return isBST(root, nil, nil)
}

private func isBST(_ node: Node?, _ min: Int?, _ max: Int?) -> Bool {
    print("Comparing: \(node?.key) min: \(min) max: \(max)")
    
    // if nil we hit the end of our branch - OK
    guard let node = node else {
        return true
    }
    
    // else check if min < parent
    if let min = min, node.key <= min {
        print("min: \(min) key: \(node.key)")
        return false
    }
    
    // check if max > parent
    if let max = max, node.key >= max {
        print("max: \(max) key: \(node.key)")
        return false
    }
    
    // if min max OK, go to next level passing in min/max and parent
    return isBST(node.left, min, node.key) && isBST(node.right, node.key, max)
}

class Tests: XCTestCase {
    
    func testIsValid1() {
        let root = Node(4)
        root.left = Node(2)
        root.right = Node(6)
        root.left?.left = Node(1)
        root.left?.right = Node(3)
        root.right?.left = Node(5)
        root.right?.right = Node(7)

        XCTAssertTrue(checkBST(root: root))
    }
    
    func testIsNotValid1() {
        let root = Node(3)
        root.left = Node(2)
        root.right = Node(4)
        root.left?.left = Node(1)
        root.right?.left = Node(5)
        root.right?.right = Node(6)

        XCTAssertFalse(checkBST(root: root))
    }

    func testIsNotValidDuplicate1() {
        let root = Node(3)
        root.left = Node(2)
        root.right = Node(5)
        root.left?.left = Node(1)
        root.right?.left = Node(6)
        root.right?.right = Node(1)

        XCTAssertFalse(checkBST(root: root))
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

//_______________________________________________________________________
/*
 TreeHeight
 https://app.codility.com/programmers/trainings/4/tree_height/
 https://github.com/raywenderlich/swift-algorithm-club/tree/master/Binary%20Search%20Tree
 
 Height is the number of steps to the lowest leaf.
 Length of the longest path.
 Tree with one node has height of zero.
   
                    20
                  /    \
                8        22
              /   \
            4       12
                  /    \
                10      14
 */
class Node2 {
    var data: Int = 0
    var left: Node2?
    var right: Node2?
    
    init(_ key: Int) {
        self.data = key
    }
    
    func height() -> Int {
        if isLeaf {
            return 0
        } else {
            return 1 + max(left?.height() ?? 0, right?.height() ?? 0)
        }
    }
    
    var isLeaf: Bool {
        return left == nil && right == nil
    }
}

let root = Node2(20)
root.left = Node2(8)
root.right = Node2(22)
root.left?.left = Node2(4)
root.left?.right = Node2(12)
root.left?.right?.left = Node2(10)
root.left?.right?.right = Node2(14)

root.height()

class Tree {
    var x: Int = 0
    var l: Tree?
    var r: Tree?
    
    init(_ key: Int) {
        self.x = key
    }
}

func solution(_ T: Tree?) -> Int {
    return height(T!)
}

func isLeaf(_ tree: Tree?) -> Bool {
    return tree?.l == nil && tree?.r == nil
}

func height(_ tree: Tree?) -> Int {
    if isLeaf(tree) {
        return 0
    } else {
        return 1 + max(height(tree?.l ?? nil), height(tree?.r ?? nil))
    }
}

class Tests2: XCTestCase {

    func testHeightOfZero() {
        let root = Node2(5)
        XCTAssertEqual(0, root.height())
    }

    func testHeightOfTwo() {
        let root = Node2(5)
        root.left = Node2(3)
        root.right = Node2(10)
        root.left?.left = Node2(20)
        root.left?.right = Node2(21)
        root.right?.left = Node2(1)

        XCTAssertEqual(2, root.height())
    }
    
    func testHeightOfThree() {
        let tree = Tree(20)
        tree.l = Tree(8)
        tree.r = Tree(22)
        tree.l?.l = Tree(4)
        tree.l?.r = Tree(12)
        tree.l?.r?.l = Tree(10)
        tree.l?.r?.r = Tree(14)

        XCTAssertEqual(3, solution(tree))
    }
}

// Infrastructure
class TestObserver3: NSObject, XCTestObservation {
    func testCase(_ testCase: XCTestCase,
                  didFailWithDescription description: String,
                  inFile filePath: String?,
                  atLine lineNumber: Int) {
        assertionFailure(description, line: UInt(lineNumber))
    }
}
let testObserver3 = TestObserver3()
XCTestObservationCenter.shared.addTestObserver(testObserver3)
Tests.defaultTestSuite.run()

//_______________________________________________________________________
import UIKit
/*
 Lowest common ancestor (LCA) in BST.
 https://www.geeksforgeeks.org/lowest-common-ancestor-in-a-binary-search-tree/
 
 O(h) - height of the tree
 
 1. If the value of the current node is less than both n1 and n2, then LCA lies in the right.
 2. If the value of the current node is greater than both n1 and n2, then LCA lies in the left.
 3. If both the above cases are false then return the current node as LCA.
 
                    20
                  /    \
                8        22
              /   \
            4       12
                  /    \
                10      14
 */
class Node3 {
    var data: Int = 0
    var left: Node3?
    var right: Node3?
    
    init(_ key: Int) {
        self.data = key
    }
}

class BinaryTree {
    var root: Node3?
    
    func lca(_ node3: Node3?, _ n1: Int, _ n2: Int) -> Node3? {
        if node3 == nil { return nil }
        
        // If both n1 and n2 are smaller than root, then LCA lies in left
        if node3!.data > n1 && node3!.data > n2 {
            return lca(node3?.left, n1, n2)
        }
        
        // If both n1 and n2 are larger than root, then LCA lies in right
        if node3!.data < n1 && node3!.data < n2 {
            return lca(node3?.right, n1, n2)
        }
        
        // Else we are at the node which is the LCA
        return node3
    }
}

let tree = BinaryTree()
tree.root = Node3(20)
tree.root?.left = Node3(8)
tree.root?.right = Node3(22)
tree.root?.left?.left = Node3(4)
tree.root?.left?.right = Node3(12)
tree.root?.left?.right?.left = Node3(10)
tree.root?.left?.right?.right = Node3(14)

var n1 = 10, n2 = 14
var t = tree.lca(tree.root, n1, n2)
print("LCA of \(n1) and \(n2) is \(String(describing: t?.data))") // 12

n1 = 14; n2 = 8
t = tree.lca(tree.root, n1, n2)
print("LCA of \(n1) and \(n2) is \(String(describing: t?.data))") // 8

n1 = 10; n2 = 22
t = tree.lca(tree.root, n1, n2)
print("LCA of \(n1) and \(n2) is \(String(describing: t?.data))") // 20
