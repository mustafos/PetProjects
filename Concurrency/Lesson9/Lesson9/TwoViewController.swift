//
//  TwoViewController.swift
//  Lesson9
//
//  Created by Mustafa Bekirov on 22.01.2023.
//

import UIKit

class TwoViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
                for i in 0...200000 {
                    print(i)
                }
        
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            DispatchQueue.concurrentPerform(iterations: 200000) {
                print("\($0) times")
                print(Thread.current)
            }
        }
        
        myInactiveQueue()
    }
    
    func myInactiveQueue() {
        let inactiveQueue = DispatchQueue(label: "Mustafa Bekirov", attributes: [.concurrent, .initiallyInactive])
        
        inactiveQueue.async {
            print("Done!")
        }
        print("not yet started...")
        inactiveQueue.activate()
        print("Activate!")
        inactiveQueue.suspend()
        print("Pause!")
        inactiveQueue.resume()
    }
}
