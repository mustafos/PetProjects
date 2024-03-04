import UIKit

class ArrayViewController: UIViewController, Operation {
    
    // MARK: – Properties
    var array: [Int] = []
    var collectionView: UICollectionView! = nil
    
    // MARK: – IBOutlets
    @IBOutlet weak var createArrayButton: UIButton!
    @IBOutlet weak var mainActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var timeBuildLabel: UILabel!
    
    // MARK: – Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar(withTitle: "Array", prefersLargeTitles: false)
        mainActivityIndicator.isHidden = true
    }
    
    // MARK: – Helpers
    
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0/2.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func configureHierarchy() {
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 100, width: view.bounds.width,
                                                        height: view.bounds.height),
                                          collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        let nib = UINib(nibName: TaskCell.reuseIdentifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: TaskCell.reuseIdentifier)
        collectionView.dataSource = self
        view.addSubview(collectionView)
    }
    
    private func measureBuildTime(block: () -> Void) -> TimeInterval {
        let startTime = Date()
        
        block() // Perform the operation
        
        let endTime = Date()
        let buildTime = endTime.timeIntervalSince(startTime)
        
        return buildTime
    }
    
    private func perfrmInsertAt(for array: [Int], numberOfElements: Int, atOnce: Bool, insertAt: Int) {
        var array = array
        if atOnce {
            let elementsToInsert = Array((0..<numberOfElements).reversed())
            array.insert(contentsOf: elementsToInsert, at: 0)
        } else {
            for i in (0..<numberOfElements).reversed() {
                array.insert(i, at: insertAt)
            }
        }
    }
    
    private func perfrmRemoveAt(for array: [Int], numberOfElements: Int, atOnce: Bool, removeAt: Int) {
        var array = array
        if atOnce {
            let rangeToRemove = removeAt..<(removeAt + numberOfElements)
            array.removeSubrange(rangeToRemove)
        } else {
            for _ in 0..<numberOfElements {
                array.remove(at: removeAt)
            }
        }
    }
    
    private func measureOperationPerfomance(for type: TaskOnArray) -> TimeInterval {
        switch type {
            case .throusndElementsAtBeginingByOne:
                return measureBuildTime { perfrmInsertAt(for: array, numberOfElements: 1000, atOnce: true, insertAt: 0) }
            case .throusndElementsAtBegining:
                return measureBuildTime { perfrmInsertAt(for: array, numberOfElements: 1000, atOnce: false, insertAt: 0) }
            case .throusndElementsAtMiddleByOne:
                return measureBuildTime { perfrmInsertAt(for: array, numberOfElements: 1000, atOnce: true, insertAt: 50000) }
            case .throusndElementsAtMiddle:
                return measureBuildTime { perfrmInsertAt(for: array, numberOfElements: 1000, atOnce: false, insertAt: 50000) }
            case .throusndElementsAtEndByOne:
                return measureBuildTime { perfrmInsertAt(for: array, numberOfElements: 1000, atOnce: true, insertAt: 9_999_998) }
            case .throusndElementsAtEnd:
                return measureBuildTime { perfrmInsertAt(for: array, numberOfElements: 1000, atOnce: false, insertAt: 9_999_998) }
            case .throusndElementsAtEndByAll:
                return measureBuildTime { perfrmInsertAt(for: array, numberOfElements: 10000, atOnce: true, insertAt: 9_999_998) }
            case .throusndElementsRemoveAtEndAll:
                return measureBuildTime { perfrmInsertAt(for: array, numberOfElements: 10000, atOnce: false, insertAt: 9_999_998) }
            case .throusndElementsRemoveAtBeginingByOne:
                return measureBuildTime { perfrmRemoveAt(for: array, numberOfElements: 1000, atOnce: true, removeAt: 0) }
            case .throusndElementsRemoveAtBegining:
                return measureBuildTime { perfrmRemoveAt(for: array, numberOfElements: 1000, atOnce: false, removeAt: 0) }
            case .throusndElementsRemoveAtMiddleByOne:
                return measureBuildTime { perfrmRemoveAt(for: array, numberOfElements: 1000, atOnce: true, removeAt: 50000) }
            case .throusndElementsRemoveAtMiddle:
                return measureBuildTime { perfrmRemoveAt(for: array, numberOfElements: 1000, atOnce: false, removeAt: 50000) }
            case .throusndElementsRemoveAtEndByOne:
                return measureBuildTime { perfrmRemoveAt(for: array, numberOfElements: 1000, atOnce: true, removeAt: 9_900_000) }
            case .throusndElementsRemoveAtEnd:
                return measureBuildTime { perfrmRemoveAt(for: array, numberOfElements: 1000, atOnce: false, removeAt: 9_900_000) }
        }
    }
    
    // MARK: – IBAction
    @IBAction func timeButtonAction(_ sender: Any) {
        createArrayButton.isHidden = true
        mainActivityIndicator.isHidden = false
        mainActivityIndicator.startAnimating()
        DispatchQueue.global(qos: .background).async { [self] in
            let createArray = measureBuildTime {
                array = Array(0..<10_000_000)
            }
            DispatchQueue.main.async {
                self.mainActivityIndicator.stopAnimating()
                self.mainActivityIndicator.isHidden = true
                self.timeBuildLabel.text = "Array creation time: \(String(format: "%.3f", createArray)) ms."
                self.configureHierarchy()
            }
        }
    }
}

extension ArrayViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return TaskOnArray.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TaskCell.reuseIdentifier, for: indexPath) as! TaskCell
        let viewModel = ArrayViewModel(task: TaskOnArray.allCases[indexPath.row])
        cell.configure(with: viewModel)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? TaskCell else { return }
        cell.activityIndicator.startAnimating()
        let operationType = TaskOnArray.allCases[indexPath.row]
        let buildTimeResult = measureOperationPerfomance(for: operationType)
        let buildTimeText = "Insertion time: \(String(format: "%.3f", buildTimeResult)) ms"
        let viewModel = ArrayViewModel(task: operationType, result: buildTimeText)
        cell.configure(with: viewModel)
        cell.activityIndicator.stopAnimating()
        cell.activityIndicator.isHidden = true
    }
}
