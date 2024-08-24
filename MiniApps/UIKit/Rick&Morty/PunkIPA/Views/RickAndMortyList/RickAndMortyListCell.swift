//
//  RickAndMortyListCell.swift
//  PunkIPA
//

import UIKit


final class RickAndMortyListCell: UITableViewCell {
    
    static let reuseID = String(String(describing: RickAndMortyListCell.self))
    
    private let imageSide: CGFloat = 60
    private let oneSize: CGFloat = 20
    
    private lazy var characterImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: oneSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var speciesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: oneSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setupConstraints()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - set data

extension RickAndMortyListCell {

    func setCharacter(_ character: Character) {
        nameLabel.text = character.name
        speciesLabel.text = character.species
    }

    func set(image: UIImage?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.characterImageView.image = image

        }
    }
}

// MARK: - UI

private extension RickAndMortyListCell {
    func setupSubviews() {
        contentView.addSubview(characterImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(speciesLabel)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate(
            [
                characterImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: oneSize),
                characterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: oneSize),
                characterImageView.rightAnchor.constraint(equalTo: nameLabel.leftAnchor, constant: -oneSize),
                characterImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -oneSize),
                characterImageView.widthAnchor.constraint(equalToConstant: imageSide),
                characterImageView.heightAnchor.constraint(equalToConstant: imageSide),

                nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: oneSize),
                nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -oneSize),
                nameLabel.rightAnchor.constraint(equalTo: speciesLabel.leftAnchor, constant: oneSize),

                speciesLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -oneSize),
                speciesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -oneSize)
            ]
        )
    }
}
