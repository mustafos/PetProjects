//
//  FeedStoriesSetCell.swift
//  Insta
//
//  Created by Mustafa Bekirov on 12.04.2023.
//

import SnapKit
import UIKit

class FeedStoriesSetCell: UITableViewCell {
    // MARK: - Public
    func configure(with info: FeedStoriesCellInfo) {
        self.items = info
        collectionView.reloadData()
    }

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private constants
    private enum UIConstants {
        static let collectionViewHeight: CGFloat = 106
        static let cellWidth: CGFloat = 72
        static let cellHeight: CGFloat = 98
    }

    // MARK: - Private properties
    private var collectionView: UICollectionView!
    private var items: FeedStoriesCellInfo = []
}

// MARK: - Private methods
private extension FeedStoriesSetCell {
    func initialize() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(StoriesItemCell.self, forCellWithReuseIdentifier: String(describing: StoriesItemCell.self))
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(UIConstants.collectionViewHeight)
        }
    }
}

// MARK: - UICollectionViewDataSource
extension FeedStoriesSetCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: StoriesItemCell.self), for: indexPath) as! StoriesItemCell
        cell.configure(with: items[indexPath.item])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FeedStoriesSetCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIConstants.cellWidth, height: UIConstants.cellHeight)
    }
}

