import Foundation

var str = "NSCondition()"

var available = false
var condition = pthread_cond_t()
var mutex = pthread_mutex_t()

class ConditionMutexPrinter: Thread {
    
    override init() {
        pthread_cond_init(&condition, nil)
        pthread_mutex_init(&mutex, nil)
    }
    
    override func main() {
        printerMethod()
    }
    
    private func printerMethod() {
        pthread_mutex_lock(&mutex)
        print("Printer enter")
        while (!available) {
            pthread_cond_wait(&condition, &mutex)
        }
        available = false
        defer {
            pthread_mutex_unlock(&mutex)
        }
        
        print("Printer exit")
    }
}

class ConditionMutexWriter: Thread {
    
    override init() {
        pthread_cond_init(&condition, nil)
        pthread_mutex_init(&mutex, nil)
    }
    
    override func main() {
        writerMethod()
    }
    
    private func writerMethod() {
        pthread_mutex_lock(&mutex)
        print("Writer enter")
        available = true
        pthread_cond_signal(&condition)
        defer {
            pthread_mutex_unlock(&mutex)
        }
        
        print("Writer exit")
    }
}

let contionMutexWriter = ConditionMutexWriter()
let contionMutexPrinter = ConditionMutexPrinter()
//contionMutexPrinter.start()
//contionMutexWriter.start()

/////////////////////////////////////

let condi = NSCondition()
var availables = false

class WriterThread: Thread {
    
    override func main() {
        condi.lock()
        print("WriterThread enter")
        availables = true
        condi.signal()
        condi.unlock()
        print("WriterThread exit")
    }
}

class PrinterThread: Thread {
    
    override func main() {
        condi.lock()
        print("PrinterThread enter")
        while(!availables) {
            condi.wait()
        }
        availables = false
        condi.unlock()
        print("PrinterThread exit")
    }
}

let writet = WriterThread()
let printet = PrinterThread()
printet.start()
writet.start()
