//
//  TableViewController.swift
//  Composite
//
//  Created by Mustafa Bekirov on 17.02.2023.
//

import UIKit

class TableViewController: UITableViewController {
    
    private var currentFolder: Compose = Folder(name: "Main")
    
    private var tableViewController: TableViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TableViewController") as? TableViewController
        return vc!
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addFileBarButton(_ sender: Any) {
        currentFolder.addComponent(c: File(name: "New file"))
        tableView.reloadData()
    }
    
    @IBAction func addFolderBarButton(_ sender: Any) {
        currentFolder.addComponent(c: Folder(name: "New folder"))
        tableView.reloadData()
    }
    
    // MARK: – Table
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentFolder.contentCount()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        guard let contents = currentFolder.showContent() as? [Compose] else {fatalError()}
        let item = contents[indexPath.row]
        
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = item is Folder ? "Folder" : "File"
        cell.imageView?.image = item is Folder ? UIImage(named: "folder") : UIImage(named: "files")
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let contents = currentFolder.showContent() as? [Compose] else {fatalError()}
        let item = contents[indexPath.row]
        
        tableViewController.currentFolder = item
        
        item is Folder ? showFolder() : print(item.showContent())
    }
    
    func showFolder() {
        navigationController?.pushViewController(tableViewController, animated: true)
    }
}
