//
//  ViewController.swift
//  HTTPRequest
//
//  Created by Mustafa Bekirov on 07.02.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource = [Post]()
    
    let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        networkManager.obtainPosts { [weak self] (result) in
            
            switch result {
                case .success(posts: let posts):
                    
                    self?.dataSource = posts
                    
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                case .failure(error: let error):
                    print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    //MARK: – UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "identifire", for: indexPath)
        let post = dataSource[indexPath.row]
        
        cell.textLabel?.text = post.title
        cell.detailTextLabel?.text = post.body
        
        return cell
    }
}

