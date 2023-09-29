import UIKit

class DictCell: UICollectionViewCell {
    
    static let reuseIdentifier = "DictCell"

    @IBOutlet var resultInCellLabel: UILabel!
    @IBOutlet weak var taskInCellButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderColor = UIColor.systemGray4.cgColor
        layer.borderWidth = 0.5
    }
    
    func configure(with viewModel: DictViewModel) {
        taskInCellButton.setTitle(viewModel.task.description, for: .normal)
        resultInCellLabel.text = viewModel.result
        taskInCellButton.isHidden = false
        activityIndicator.stopAnimating()
    }
    
    @IBAction func taskAction(_ sender: Any) {
        taskInCellButton.isHidden = true
        activityIndicator.startAnimating()
    }
}
