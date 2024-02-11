import UIKit

struct DictViewModel {
    let task: TaskOnDictionary
    let result: String
    
    init(task: TaskOnDictionary, result: String = "") {
        self.task = task
        self.result = result
    }
}
