import UIKit

class ViewController: UIViewController {
    
    // MARK: – Properties
    
    private let tableView = UITableView()
    private let reuseIdentifier = "MainCell"
    
    // MARK: – Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar(withTitle: "Collections", prefersLargeTitles: true)
        navigationController?.navigationBar.barStyle = .black
    }
    
    // MARK: – Helpers
    
    private func configureUI() {
        view.backgroundColor = .white
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.backgroundColor = .white
        tableView.rowHeight = 40
        tableView.register(MainCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.frame = view.frame
    }
}

// MARK: – UITableViewDataSource

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MainViewModel.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MainCell
        let viewModel = MainViewModel(rawValue: indexPath.row)
        cell.viewModel = viewModel
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}

// MARK: – UITableViewDelegate

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = MainViewModel(rawValue: indexPath.row) else { return }
        switch viewModel {
            case .array1:
                let arrayController = ArrayViewController()
                navigationController?.pushViewController(arrayController, animated: true)
            case .set2:
                let setController = SetViewController()
                navigationController?.pushViewController(setController, animated: true)
            case .dictionary3:
                let dictionaryController = DictionaryViewController()
                navigationController?.pushViewController(dictionaryController, animated: true)
        }
    }
}
