//
//  ViewController.swift
//  FactoryMethod
//
//  Created by Mustafa Bekirov on 12.02.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var exerciseArray = [Exercise]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createExercise(exName: .jumping)
        createExercise(exName: .squatting)
        runExercise()
        
    }
    
    func createExercise(exName: Exercises) {
        let newExercise = FactoryExercises.defaultFactory.createExercise(name: exName)
        exerciseArray.append(newExercise)
    }
    
    func runExercise() {
        for ex in exerciseArray {
            ex.start()
            ex.stop()
        }
    }
    
    


}

