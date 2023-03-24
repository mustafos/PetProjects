import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

var greeting = "Operation | OperationQueue | OperationBlock"

print(Thread.current)

let operation1 = {
    print("Start")
    print(Thread.current)
    print("finish")
}

let queue = OperationQueue()
queue.addOperation(operation1)

//============================

print(Thread.current)

var result: String?
let concatOperation = BlockOperation {
    result = "The Swift" + " " + "Development"
    print(Thread.current)
}

concatOperation.start()

print(result!)

let queue = OperationQueue()
queue.addOperation(concatOperation)
print(result!)
print(Thread.current)

//============================

let queue1 = OperationQueue()
queue1.addOperation {
    print("test")
    print(Thread.current)
}

//============================

class MyThread: Thread {
    override func main() {
        print("Test main thread")
    }
}

let myThread = MyThread()
myThread.start()

============================

print(Thread.current)
class OperationA: Operation {
    override func main() {
        print("Test operaion A")
        print(Thread.current)
    }
}

let operationA = OperationA()
operationA.start()

let queue1 = OperationQueue()
queue1.addOperation(operationA)
 
//============================ Part 2 ============================

let operationQueue = OperationQueue()

class OperationCancelTest: Operation {
    override func main() {
        if isCancelled {
            print(isCancelled)
            return
        }
        print("test 1")
        sleep(1)
        
        if isCancelled {
            print(isCancelled)
            return
        }
        print("test 2")
    }
}

func cancelOperationMethod() {
    let cancelOperation = OperationCancelTest()
    operationQueue.addOperation(cancelOperation)
    cancelOperation.cancel()
}
//cancelOperationMethod()

class WaitOperationTest {
    private let operationQueue = OperationQueue()
    
    func test() {
        operationQueue.addOperation {
            sleep(1)
            print("test 1")
        }
        operationQueue.addOperation {
            sleep(2)
            print("test 2")
        }
        operationQueue.waitUntilAllOperationsAreFinished()
        operationQueue.addOperation {
            print("test 3")
        }
        operationQueue.addOperation {
            print("test 4")
        }
    }
}

let waitOperationTest = WaitOperationTest()
//waitOperationTest.test()

class WaitOperationTest2 {
    private let operationQueue = OperationQueue()
    
    func test() {
        let operation1 = BlockOperation {
            sleep(1)
            print("test 1")
        }
        let operation2 = BlockOperation {
            sleep(2)
            print("test 2")
        }
       
        operationQueue.addOperations([operation1, operation2], waitUntilFinished: true)
    }
}

let waitOperationTest2 = WaitOperationTest2()
//waitOperationTest2.test()

class CompletionBlockTest {
    private let operationQueue = OperationQueue()
    
    func test() {
        let operation1 = BlockOperation {
            sleep(3)
            print("test CompletionBlock")
        }
        operation1.completionBlock = {
            print("finish completionBlock")
        }
        operationQueue.addOperation(operation1)
    }
}

let completionBlockTest = CompletionBlockTest()
completionBlockTest.test()
