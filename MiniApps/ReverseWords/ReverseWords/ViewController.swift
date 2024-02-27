import UIKit

class ViewController: UIViewController {
    
    // MARK: – Properties
    let model = ReverseWordsModel()
    
    // MARK: – Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var wordsTextField: UITextField!
    @IBOutlet weak var resultTextView: UITextView!
    @IBOutlet weak var reverseButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    
    // MARK: – Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        wordsTextField.delegate = self
    }
    
    // MARK: – Actions
    @IBAction private func reverseButtonAction(_ sender: Any) {
        guard let inputText = wordsTextField.text else { return }
        let revert = model.reverseWords(in: inputText)
        if !revert.isEmpty {
            resultTextView.text = revert
            reverseButton.isHidden = true
            clearButton.isHidden = false
        }
    }
    
    @IBAction private func clearButtonAction(_ sender: Any) {
        if reverseButton.isHidden {
            wordsTextField.text = ""
            resultTextView.text = ""
            clearButton.isHidden = true
            reverseButton.isHidden = false
            reverseButton.alpha = 0.6
        }
    }
    
    // MARK: – Helpers
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        wordsTextField.underlined(color: .systemGray)
        view.endEditing(true)
    }
    
    private func configureUI() {
        clearButton.isHidden = true
        reverseButton.layer.cornerRadius = 14
        clearButton.layer.cornerRadius = 14
        reverseButton.alpha = 0.6
        layoutButton()
        wordsTextField.underlined(color: .systemGray)
    }
    
    private func layoutButton() {
                
        view.addSubview(reverseButton)
        reverseButton.translatesAutoresizingMaskIntoConstraints = false
        reverseButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        reverseButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 13).isActive = true
        reverseButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -13).isActive = true
        reverseButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -66).isActive = true
        
        view.addSubview(clearButton)
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        clearButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        clearButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 13).isActive = true
        clearButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -13).isActive = true
        clearButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -66).isActive = true
    }
}

// MARK: – UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        wordsTextField.underlined(color: .systemBlue)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        reverseButton.alpha = 1
        return true
    }
}
