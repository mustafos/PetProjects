import UIKit

var array = [1, 2, 3, 4, 5]

struct LinkedList<T> {
    var head: LinkedListNode<T>
    init(head: LinkedListNode<T>) {
        self.head = head
    }
}

indirect enum LinkedListNode<T> {
    case value(element: T, next: LinkedListNode<T>)
    case end
}

let element4 = LinkedListNode.value(element: 4, next: .end)
let element3 = LinkedListNode.value(element: 3, next: element4)
let element2 = LinkedListNode.value(element: 2, next: element3)
let element1 = LinkedListNode.value(element: 1, next: element2)
let list = LinkedList(head: element1)

extension LinkedList: Sequence {
    func makeIterator() -> LinkedListIterator<T> {
        return LinkedListIterator(current: head)
    }
}

struct LinkedListIterator<T>: IteratorProtocol {
    var current: LinkedListNode<T>
    
    mutating func next() -> T? {
        switch current {
            case let .value(element, next):
                current = next
                return element
            case .end: return nil
        }
    }
}

for i in list {
    print(i)
}

list.contains(3)
