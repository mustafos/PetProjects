import UIKit

struct ArrayViewModel {
    let task: TaskOnArray
    let result: String
    
    init(task: TaskOnArray, result: String = "") {
        self.task = task
        self.result = result
    }
}
