import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

var greeting = "GCD Semaphores"

let queue = DispatchQueue(label: "mustafos", attributes: .concurrent)

let semaphore = DispatchSemaphore(value: 0)

queue.async {
    semaphore.wait() // -1
    sleep(3)
    print("method 1")
    semaphore.signal() // +1
}

queue.async {
    semaphore.wait() // -1
    sleep(3)
    print("method 2")
    semaphore.signal() // +1
}

queue.async {
    semaphore.wait() // -1
    sleep(3)
    print("method 3")
    semaphore.signal() // +1
}

let sem = DispatchSemaphore(value: 2)

DispatchQueue.concurrentPerform(iterations: 10) { (id: Int) in
    sem.wait(timeout: DispatchTime.distantFuture)
    sleep(1)
    print("Block", String(id))
    
    sem.signal()
}

class SemaphoreTest {
    private let semaphore = DispatchSemaphore(value: 2)
    private var array = [Int]()
    
    private func methodWork(_ id: Int) {
        semaphore.wait() // -1
        
        array.append(id)
        print("test array", array.count)
        
        Thread.sleep(forTimeInterval: 2)
        semaphore.signal() // +1
    }
    
    public func startAllThread() {
        DispatchQueue.global().async {
            self.methodWork(111)
        }
        DispatchQueue.global().async {
            self.methodWork(1546)
        }
        DispatchQueue.global().async {
            self.methodWork(1375)
        }
        DispatchQueue.global().async {
            self.methodWork(8329)
        }
    }
}

let semaphoreTest = SemaphoreTest()

semaphoreTest.startAllThread()
