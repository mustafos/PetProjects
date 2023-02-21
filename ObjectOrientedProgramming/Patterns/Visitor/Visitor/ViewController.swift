//
//  ViewController.swift
//  Visitor
//
//  Created by Mustafa Bekirov on 19.02.2023.
//

import UIKit

class FirsCell: UITableViewCell { /**/ }
class SecondCell: UITableViewCell { /**/ }
class ThirdCell: UITableViewCell { /**/ }

struct HeightResultVisitor {
    func visit(_ cell: FirsCell) -> CGFloat { return 10.0 }
    func visit(_ cell: SecondCell) -> CGFloat { return 20.0 }
    func visit(_ cell: ThirdCell) -> CGFloat { return 30.0 }
}

protocol HeightResultVisitable {
    func accept(_ visitor: HeightResultVisitor) -> CGFloat
}

extension FirsCell: HeightResultVisitable {
    func accept(_ visitor: HeightResultVisitor) -> CGFloat {
        return visitor.visit(self)
    }
}

extension SecondCell: HeightResultVisitable {
    func accept(_ visitor: HeightResultVisitor) -> CGFloat {
        return visitor.visit(self)
    }
}

extension ThirdCell: HeightResultVisitable {
    func accept(_ visitor: HeightResultVisitor) -> CGFloat {
        return visitor.visit(self)
    }
}


class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    func registerCell() {
        tableView.register(FirsCell.self, forCellReuseIdentifier: "FirsCell")
        tableView.register(SecondCell.self, forCellReuseIdentifier: "SecondCell")
        tableView.register(ThirdCell.self, forCellReuseIdentifier: "ThirdCell")
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /**/ return FirsCell()
        /**/ return SecondCell()
        /**/ return ThirdCell()
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = tableView.cellForRow(at: indexPath) as! HeightResultVisitable
        return cell.accept(HeightResultVisitor())
    }
}
