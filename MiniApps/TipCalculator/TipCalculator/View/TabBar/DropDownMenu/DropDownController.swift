//
//  DropDownController.swift
//  TipCalculator
//
//  Created by Mustafa Bekirov on 07.01.2024.
//

import UIKit

class DropDownController: UIViewController {
    // MARK: – IBOutlet
    @IBOutlet weak var dropDownButton: UIButton!
    @IBOutlet weak var tableViewMenu: UITableView!
    
    @IBOutlet weak var showButton: UIButton!
    @IBOutlet weak var showLabel: UILabel!
    
    private let itemList = ["Item1", "Item2", "Item3", "Item4", "Item5", "Item6"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        tableViewMenu.isHidden = true
        showLabel.isHidden = true
        showLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer dignissim enim ut metus convallis aliquam."
    }
    
    @IBAction func openDropMenu(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.tableViewMenu.isHidden.toggle()
            self.dropDownButton.setImage(UIImage(systemName: self.tableViewMenu.isHidden ? "chevron.down" : "chevron.up"), for: .normal)
        }
    }
    
    @IBAction func openShowMenu(_ sender: Any) {
        self.showLabel.isHidden.toggle()
    }
}

extension DropDownController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        cell.textLabel?.text = itemList[indexPath.row]
        cell.imageView?.image = UIImage(systemName: "star.fill")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dropDownButton.setTitle("\(itemList[indexPath.row])", for: .normal)
        tableViewMenu.isHidden = false
    }
}
