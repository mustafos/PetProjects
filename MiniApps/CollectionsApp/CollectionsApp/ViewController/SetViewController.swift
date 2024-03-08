import UIKit

class SetViewController: UITableViewController {
    
    var textField1: UITextField!
    var textField2: UITextField!
    var resultLabel: UILabel!
    var matchingButton: UIButton!
    var nonMatchingButton: UIButton!
    var uniqueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: – Selectors
    
    @objc func displayMatching() {
        let text1 = textField1.text ?? ""
        let text2 = textField2.text ?? ""
        
        let matchingSet = Set(text1).intersection(Set(text2))
        let matchingCharacters = matchingSet.sorted()
        
        resultLabel.text = "\(String(matchingCharacters))"
    }
    
    @objc func displayNonMatching() {
        let text1 = textField1.text ?? ""
        let text2 = textField2.text ?? ""
        
        let nonMatchingSet = Set(text1).symmetricDifference(Set(text2))
        let nonMatchingCharacters = nonMatchingSet.sorted()
        
        resultLabel.text = "\(String(nonMatchingCharacters))"
    }
    
    @objc func displayUnique() {
        let text1 = textField1.text ?? ""
        let text2 = textField2.text ?? ""
        
        let uniqueSet = Set(text1).subtracting(Set(text2))
        let uniqueCharacters = uniqueSet.sorted()
        
        resultLabel.text = "\(String(uniqueCharacters))"
    }
    
    @objc func onHideKeyboardButtonAction() {
        UIApplication.shared.sendAction(
            #selector(UIApplication.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
    
    
    // MARK: – Helpers
    
    func configureUI() -> Void {
        configureNavigationBar(withTitle: "Sets", prefersLargeTitles: false)
        
        // Create and position the text fields
        textField1 = UITextField(frame: CGRect(x: 26, y: 30, width: 343, height: 36))
        textField2 = UITextField(frame: CGRect(x: 26, y: 90, width: 343, height: 36))
        
        textField1.borderStyle = UITextField.BorderStyle.roundedRect
        textField2.borderStyle = UITextField.BorderStyle.roundedRect
        
        view.addSubview(textField1)
        view.addSubview(textField2)
        
        // Create and position the buttons
        matchingButton = UIButton(type: .system)
        matchingButton.frame = CGRect(x: 90, y: 150, width: 200, height: 30)
        matchingButton.setTitle("Display Matching", for: .normal)
        matchingButton.addTarget(self, action: #selector(displayMatching), for: .touchUpInside)
        view.addSubview(matchingButton)
        
        nonMatchingButton = UIButton(type: .system)
        nonMatchingButton.frame = CGRect(x: 90, y: 180, width: 200, height: 30)
        nonMatchingButton.setTitle("Display Non-Matching", for: .normal)
        nonMatchingButton.addTarget(self, action: #selector(displayNonMatching), for: .touchUpInside)
        view.addSubview(nonMatchingButton)
        
        uniqueButton = UIButton(type: .system)
        uniqueButton.frame = CGRect(x: 90, y: 210, width: 200, height: 30)
        uniqueButton.setTitle("Display Unique", for: .normal)
        uniqueButton.addTarget(self, action: #selector(displayUnique), for: .touchUpInside)
        view.addSubview(uniqueButton)
        
        // Create the label to display the results
        resultLabel = UILabel(frame: CGRect(x: 90, y: 270, width: 200, height: 30))
        resultLabel.textAlignment = .center
        view.addSubview(resultLabel)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
