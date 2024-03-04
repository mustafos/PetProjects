import UIKit

class DictionaryViewController: UIViewController, UICollectionViewDataSource, Operation {
    
    var collectionView: UICollectionView! = nil
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar(withTitle: "Dictionary", prefersLargeTitles: false)
        activityIndicator.stopAnimating()
        configureHierarchy()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        activityIndicator.startAnimating()
    }
    
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
        let nib = UINib(nibName: DictCell.reuseIdentifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: DictCell.reuseIdentifier)
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
    
    private func perfrmArrDict(str: Bool, atCallection: Bool, atPosition: Bool) {
        // Generate an array of contact numbers
        let contactNumbersArray: [Int] = [1234567890, 9876543210, 5551234567, 1112223333]
        
        // Generate a dictionary of contact numbers with corresponding names
        let contactNumbersDictionary: [String : Int] = [
            "John": 1234567890,
            "Jane": 9876543210,
            "Mike": 5551234567,
            "Sarah": 1112223333
        ]
        
        if str {
            if atCallection {
                if atPosition {
                    let firstElement = contactNumbersArray.first
                    print("First element in array: \(String(describing: firstElement))")
                } else {
                    let lastElement = contactNumbersArray.last
                    print("Last element in array: \(String(describing: lastElement))")
                }
            } else {
                if atPosition {
                    let firstElement = contactNumbersDictionary.first
                    print("First element in dictionary: \(String(describing: firstElement))")
                } else {
                    let lastElement = contactNumbersDictionary.endIndex
                    print("Last element in dictionary: \(String(describing: lastElement))")
                }
            }
        } else {
            if atCallection {
                let nonExistingElement = contactNumbersArray.first { element in
                    return element == -1
                }
                if nonExistingElement != nil {
                    print("Non-existing element found in array")
                } else {
                    print("Non-existing element not found in array")
                }
            } else {
                let nonExistingValue = contactNumbersDictionary.first { (_, value) in
                    return value == -1
                }
                if nonExistingValue != nil {
                    print("Non-existing value found in dictionary")
                } else {
                    print("Non-existing value not found in dictionary")
                }
            }
        }
    }
    
    private func measureOperationPerfomance(for type: TaskOnDictionary) -> TimeInterval {
        switch type {
            case .findTheFirstContactInArray:
                return measureBuildTime { perfrmArrDict(str: true, atCallection: true, atPosition: true) }
            case .findTheFirstContactInDictionary:
                return measureBuildTime { perfrmArrDict(str: true, atCallection: false, atPosition: true) }
            case .findTheLastContactInArray:
                return measureBuildTime { perfrmArrDict(str: true, atCallection: true, atPosition: false) }
            case .findTheLastContactInDictionary:
                return measureBuildTime { perfrmArrDict(str: true, atCallection: false, atPosition: false) }
            case .searchForNonExistArray:
                return measureBuildTime { perfrmArrDict(str: false, atCallection: true, atPosition: true) }
            case .searchForNonExistDictionary:
                return measureBuildTime { perfrmArrDict(str: false, atCallection: false, atPosition: false) }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return TaskOnDictionary.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DictCell.reuseIdentifier, for: indexPath) as! DictCell
        let viewModel = DictViewModel(task: TaskOnDictionary.allCases[indexPath.row])
        cell.configure(with: viewModel)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? DictCell else { return }
        cell.activityIndicator.startAnimating()
        let operationType = TaskOnDictionary.allCases[indexPath.row]
        let buildTimeResult = measureOperationPerfomance(for: operationType)
        let buildTimeText = "Insertion time: \(String(format: "%.3f", buildTimeResult)) ms"
        let viewModel = DictViewModel(task: operationType, result: buildTimeText)
        cell.configure(with: viewModel)
        cell.activityIndicator.stopAnimating()
    }
}
