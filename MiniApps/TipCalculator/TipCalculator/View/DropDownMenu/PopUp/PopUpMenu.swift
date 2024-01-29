//
//  PopUpMenu.swift
//  TipCalculator
//
//  Created by Mustafa Bekirov on 28.01.2024.
//

import UIKit

class PopUpMenu: UIViewController {
    let dataSource = ["Apple", "Mango", "Orange", "Banana", "Kiwi", "Watermelon"]
    
    @IBOutlet weak var tableViewButton: UIButton!
    
    let tableView = UITableView()
    let transparentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addTableView(frames: tableViewButton.frame)
    }
    
    func addTableView(frames: CGRect) {
        let tableViewHeight = (dataSource.count > 3) ? 120.0 : CGFloat(dataSource.count) * tableView.rowHeight
        tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: tableViewHeight)
        self.view.addSubview(tableView)
        tableView.layer.cornerRadius = 5
        tableView.separatorStyle = .none
        tableView.layer.borderColor = UIColor.systemGray5.cgColor
        tableView.layer.borderWidth = 1.0
        
        tableView.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .none)
        tableViewButton.setTitle(dataSource[0], for: .normal)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideTableView))
        transparentView.addGestureRecognizer(tapGesture)
        
        tableView.isHidden = true
//        transparentView.isHidden = true
    }
    
    @objc private func showTableView(frames: CGRect) {
        tableView.isHidden.toggle()
//        transparentView.isHidden = false
    }
    
    @objc private func hideTableView() {
        tableView.isHidden.toggle()
//        transparentView.isHidden = true
    }
    
    @IBAction func onShowTableViewButtonPressed(_ sender: UIButton) {
        showTableView(frames: sender.frame)
    }
}

extension PopUpMenu: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableViewButton.setTitle(dataSource[indexPath.row], for: .normal)
        hideTableView()
    }
}
