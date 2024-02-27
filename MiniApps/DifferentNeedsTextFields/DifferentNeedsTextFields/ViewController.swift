import UIKit
import SafariServices

class ViewController: UIViewController {
    
    // MARK: – Properties
    private let maxInputSize = 10
    
    // MARK: – IBOutlets
    @IBOutlet weak var firstView: CustomView! {
        didSet {
            firstView.inputTextField.accessibilityIdentifier = "firstView"
        }
    }
    @IBOutlet weak var secondView: CustomView! {
        didSet {
            secondView.inputTextField.accessibilityIdentifier = "secondView"
        }
    }
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var thirdView: CustomView! {
        didSet {
            thirdView.inputTextField.accessibilityIdentifier = "thirdView"
        }
    }
    @IBOutlet weak var fourthView: CustomView! {
        didSet {
            fourthView.inputTextField.accessibilityIdentifier = "fouthView"
        }
    }
    @IBOutlet weak var fifthView: CustomView! {
        didSet {
            fifthView.inputTextField.accessibilityIdentifier = "fifthView"
        }
    }
    
    @IBOutlet weak var lengthCharLabel: UILabel!
    @IBOutlet weak var digitLabel: UILabel!
    @IBOutlet weak var lowercaseLabel: UILabel!
    @IBOutlet weak var capitalRequiredLabel: UILabel!
    
    var safariVC: SFSafariViewController?
    let linkRegex = try! NSRegularExpression(pattern: "http[s]?://[\\w\\.-]+(?:/[^\\s]*)?")
    
    // MARK: – Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
    }
    
    // MARK: – Helpers
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func updateCounterLabel(with remaining: Int = 10) {
        counterLabel.textColor = .gray
        counterLabel.text = "\(remaining)/\(maxInputSize)"
    }
    
    func keyboardEvent() -> Void {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: – Selectors
    @objc private func keyboardWillShow(notification: Notification) {
        // Get keyboard size and animation duration
        if let userInfo = notification.userInfo,
           let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
           let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
            
            // Calculate overlap of keyboard with the text field
            let view = viewForTextFieldBeingEdited()
            let convertedRect = view.convert(view.bounds, to: nil)
            let keyboardOverlap = convertedRect.maxY - keyboardSize.minY
            
            // If there is overlap, move the text field up
            if keyboardOverlap > 0 {
                UIView.animate(withDuration: duration) {
                    self.view.frame.origin.y -= keyboardOverlap
                }
            }
        }
    }

    @objc private func keyboardWillHide(notification: Notification) {
        // Reset view to original position
        if let userInfo = notification.userInfo,
           let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
            UIView.animate(withDuration: duration) {
                self.view.frame.origin.y = 0
            }
        }
    }

}

// MARK: – Setup
extension ViewController {

    private func setup() {
        configureUI()
        delegationTextFields()
        configureView()
    }
    
    private func style() {
        secondView.inputTextField.layer.cornerRadius = 5
        fifthView.inputTextField.layer.cornerRadius = 5
        counterLabel.textColor = .gray
        view.insertSubview(counterLabel, aboveSubview: secondView.inputTextField)
        counterLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            counterLabel.trailingAnchor.constraint(equalTo: secondView.inputTextField.trailingAnchor, constant: -20.0),
            counterLabel.centerYAnchor.constraint(equalTo: secondView.inputTextField.bottomAnchor)
        ])
    }
    
    private func configureUI() -> Void {
        firstView.configure(viewModel: CustomView.ViewModel(nameTF: "NO digits field", placNameTF: "Type here"))
        secondView.configure(viewModel: CustomView.ViewModel(nameTF: "Input limit", placNameTF: "Type here"))
        thirdView.configure(viewModel: CustomView.ViewModel(nameTF: "Only characters", placNameTF: "wwwww–ddddd"))
        fourthView.configure(viewModel: CustomView.ViewModel(nameTF: "Link", placNameTF: "www.example.com"))
        fifthView.configure(viewModel: CustomView.ViewModel(nameTF: "Validation rules", placNameTF: "Password"))
    }
    
    func delegationTextFields() -> Void {
        firstView.inputTextField.delegate = self
        secondView.inputTextField.delegate = self
        thirdView.inputTextField.delegate = self
        fourthView.inputTextField.delegate = self
        fifthView.inputTextField.delegate = self
    }
    
    func configureView() -> Void {
        fifthView.inputTextField.isSecureTextEntry = true
        fifthView.inputTextField.textContentType = .password
        keyboardEvent()
        updateCounterLabel()
    }
}

// MARK: – UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    
    private func viewForTextFieldBeingEdited() -> UIView {
        // Return the view that the keyboard is overlapping with
        if firstView.inputTextField.isEditing {
            return firstView.inputTextField
        } else if secondView.inputTextField.isEditing {
            return secondView.inputTextField
        } else if thirdView.inputTextField.isEditing {
            return thirdView.inputTextField
        } else {
            return view
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == fourthView.inputTextField {
            if let text = fourthView.inputTextField.text, !text.isEmpty {
                // delay before checking for link
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    if let match = self.linkRegex.firstMatch(in: text, options: [], range: NSRange(location: 0, length: text.count)), match.range == NSRange(location: 0, length: text.count) {
                        // valid link detected
                        if let url = URL(string: text) {
                            let safariVC = SFSafariViewController(url: url)
                            self.present(safariVC, animated: true, completion: nil)
                            self.safariVC = safariVC
                        }
                    }
                }
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        // TF1
        if textField == firstView.inputTextField {
            let filteredString = string.filter { !$0.isNumber }
            let newText = (text as NSString).replacingCharacters(in: range, with: filteredString)
            firstView.inputTextField.text = newText
            return false
        }
        // TF2
        if textField == secondView.inputTextField {
            let newLength = text.count - range.length + string.count
            if newLength >= maxInputSize + 1 {
                counterLabel.textColor = .red
                counterLabel.text = " -\(newLength - maxInputSize) "
                secondView.inputTextField.layer.borderWidth = 2
                secondView.inputTextField.layer.borderColor = UIColor.red.cgColor
                return false
            } else {
                updateCounterLabel(with: maxInputSize - newLength)
                secondView.inputTextField.layer.borderWidth = 0
                return true
            }
        }
        // TF3
        if textField == thirdView.inputTextField {
            var allowedCharacterSet = CharacterSet.alphanumerics
            allowedCharacterSet.insert("-")
            let replacementCharacterSet = CharacterSet(charactersIn: string)
            if !replacementCharacterSet.isSubset(of: allowedCharacterSet) {
                return false
            }
            let text = thirdView.inputTextField.text! as NSString
            let newText = text.replacingCharacters(in: range, with: string) as NSString
            let mask = "wwwww-ddddd"
            var formattedText = ""
            var currentIndex = 0
            for char in mask {
                if currentIndex >= newText.length {
                    break
                }
                if char == "w" {
                    let substring = newText.substring(with: NSRange(location: currentIndex, length: 1))
                    if CharacterSet.letters.contains(substring.unicodeScalars.first!) {
                        formattedText.append(substring)
                    }
                } else if char == "d" {
                    let substring = newText.substring(with: NSRange(location: currentIndex, length: 1))
                    if CharacterSet.decimalDigits.contains(substring.unicodeScalars.first!) {
                        formattedText.append(substring)
                    }
                } else {
                    formattedText.append(char)
                }
                currentIndex += 1
            }
            thirdView.inputTextField.text = formattedText
            return false
        }
        
        // TF5
        if textField == fifthView.inputTextField {
            // Get the current text in the text field
            let currentText = textField.text ?? ""
            
            // Get the new text that would be entered after the user types
            guard let stringRange = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            
            // Check if all password requirements are met
            let hasCapitalLetter = updatedText.rangeOfCharacter(from: .uppercaseLetters) != nil
            let hasLowercaseLetter = updatedText.rangeOfCharacter(from: .lowercaseLetters) != nil
            let hasDigit = updatedText.rangeOfCharacter(from: .decimalDigits) != nil
            
            // Update the labels
            lengthCharLabel.textColor = updatedText.count >= 8 ? .green : .red
            digitLabel.textColor = hasDigit ? .green : .red
            lowercaseLabel.textColor = hasLowercaseLetter ? .green : .red
            capitalRequiredLabel.textColor = hasCapitalLetter ? .green : .red
            
            // Highlight the entire password field if all requirements are met
            if updatedText.count >= 8 && hasDigit && hasLowercaseLetter && hasCapitalLetter {
                textField.layer.borderColor = UIColor.green.cgColor
                textField.layer.borderWidth = 5
            } else {
                textField.layer.borderColor = UIColor.clear.cgColor
                textField.layer.borderWidth = 0
            }
            return true
        }
        return true
    }
}
