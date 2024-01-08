//
//  DropDownController.swift
//  TipCalculator
//
//  Created by Mustafa Bekirov on 07.01.2024.
//

import UIKit

class DropDownController: UIViewController {

    @IBOutlet weak var dropDownButton: UIButton!
    @IBOutlet weak var tableViewMenu: UITableView!
    
    private var itemList = ["Item1", "Item2", "Item3", "Item4", "Item5", "Item6"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func openDropMenu(_ sender: Any) {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DropDownController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView
    }
}
