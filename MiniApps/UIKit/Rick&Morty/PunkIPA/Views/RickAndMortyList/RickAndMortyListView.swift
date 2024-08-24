//
//  BeerListView.swift
//  PunkIPA
//

import UIKit

final class RickAndMortyCharacterListView: UITableViewController {
    private let viewModel: RickAndMortyCharacterViewModel
    
    init(viewModel: RickAndMortyCharacterViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
}

// MARK: - UITableViewDataSource

extension RickAndMortyCharacterListView {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: implement logic
        return viewModel.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: implement logic
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RickAndMortyListCell.reuseID, for: indexPath) as? RickAndMortyListCell else {
            return UITableViewCell()
        }
        
        let character = viewModel.items[indexPath.row]
        cell.setCharacter(character)
        
        // Load the character's image asynchronously
        viewModel.loadImage(for: character.image) { image in
            cell.set(image: image)
        }
        
        return cell
    }
}

private extension RickAndMortyCharacterListView {
    func registerCells() {
        tableView.register(RickAndMortyListCell.self, forCellReuseIdentifier: "RickAndMortyListCell")
    }
    
    func loadData() {
        viewModel.fetchCharacters { [weak self] in
            self?.reloadData()
        }
    }
    
    func reloadData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.tableView.reloadData()
            
        }
    }
}
