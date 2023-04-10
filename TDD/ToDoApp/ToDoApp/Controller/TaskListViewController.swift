//
//  TaskListViewController.swift
//  ToDoApp
//
//  Created by Mustafa Bekirov on 08.04.2023.
//

import UIKit

class TaskListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var dataProvider: DataProvider!
    
    @IBAction func addNewTask(_ sender: UIBarButtonItem) {
        if let viewController = storyboard?.instantiateViewController(withIdentifier: String(describing: NewTaskViewController.self)) as? NewTaskViewController {
            present(viewController, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
