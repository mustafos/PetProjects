//
//  ViewController.swift
//  Lesson9
//
//  Created by Mustafa Bekirov on 22.01.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        afterBlock(second: 4, queue: .global()) {
            print("Hello")
            print(Thread.current)
        }
        afterBlock(second: 2) {
            print("Hello")
            self.showAlert()
            print(Thread.current)
        }
        
    }
    
    func showAlert() {
        let alert = UIAlertController(title: nil, message: "Hello", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    func afterBlock(second: Int, queue: DispatchQueue = DispatchQueue.global(), complition: @escaping ()->()) {
        queue.asyncAfter(deadline: .now() + .seconds(second)) {
            complition()
        }
    }


}


