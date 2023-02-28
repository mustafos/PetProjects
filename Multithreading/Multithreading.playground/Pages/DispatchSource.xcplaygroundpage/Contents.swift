import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

var greeting = "DispatchSource"

let timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
timer.setEventHandler {
    print("!")
}

timer.schedule(deadline: .now(), repeating: 5)
timer.activate()
