import UIKit

class AnagramsViewController: UIViewController {
    
    // MARK: – Properties
    let model = ReverseWordsModel()
    
    // MARK: – Outlets
    @IBOutlet weak var toReverseTextField: UITextField! {
        didSet {
            toReverseTextField.accessibilityIdentifier = "toReverseTextField"
        }
    }
    @IBOutlet weak var changeLogic: UISegmentedControl! {
        didSet {
            changeLogic.accessibilityIdentifier = "changeLogic"
        }
    }
    @IBOutlet weak var infoLabel: UILabel! {
        didSet {
            infoLabel.accessibilityIdentifier = "infoLabel"
        }
    }
    @IBOutlet weak var ignoredTextField: UITextField! {
        didSet {
            ignoredTextField.accessibilityIdentifier = "toIgnoreTextField"
        }
    }
    @IBOutlet weak var resultLabel: UILabel! {
        didSet {
            resultLabel.accessibilityIdentifier = "resultLabel"
        }
    }
    
    // MARK: – Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        toReverseTextField.delegate = self
        ignoredTextField.delegate = self
        
    }
    
    // MARK: – Helpers
    
    private func configureUI() -> Void {
        addKeyboardHideOnTappedAroundRecognizer()
        infoLabel.isHidden = false
        ignoredTextField.isHidden = true
    }
    
    // MARK: – Actions
    @IBAction private func customChange(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            case 0:
                infoLabel.isHidden = false
                ignoredTextField.isHidden = true
                let revert = model.reverseExceptAlphabeticSymbols(in: toReverseTextField.text ?? "")
                resultLabel.text = revert
            case 1:
                infoLabel.isHidden = true
                ignoredTextField.isHidden = false
                let revert = model.reverseIgnoredUserDefined(in: toReverseTextField.text ?? "", ignoredChars: ignoredTextField.text ?? "")
                resultLabel.text = revert
            default:
                break
        }
    }
}

// MARK: – UIViewController

extension UIViewController {
    func addKeyboardHideOnTappedAroundRecognizer(cancelsTouchesInView: Bool = true) {
        let endEditingTapRecognizer = UITapGestureRecognizer(
            target: view,
            action: #selector(UIView.endEditing)
        )
        endEditingTapRecognizer.cancelsTouchesInView = cancelsTouchesInView
        view.addGestureRecognizer(endEditingTapRecognizer)
    }
}

// MARK: – UITextFieldDelegate
extension AnagramsViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var inputStr = toReverseTextField.text ?? ""
        inputStr = (inputStr as NSString).replacingCharacters(in: range, with: string)
        if changeLogic.selectedSegmentIndex == 0 {
            let revert = model.reverseExceptAlphabeticSymbols(in: inputStr)
            resultLabel.text = revert + " "
        }
        if changeLogic.selectedSegmentIndex == 1 {
            let revert2 = model.reverseIgnoredUserDefined(in: toReverseTextField.text!, ignoredChars: ignoredTextField.text ?? "")
            resultLabel.text = revert2 + " "
        }
        return true
    }
}
