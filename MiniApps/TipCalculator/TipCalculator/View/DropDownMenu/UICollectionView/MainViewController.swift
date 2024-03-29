//
//  MainViewController.swift
//  TipCalculator
//
//  Created by Mustafa Bekirov on 30.12.2023.
//

import UIKit
import RxSwift
import SnapKit
import SwifterSwift

class MainViewController: BaseViewController {
    
    private let sizingCell = ExpandableCell()
    let itemList: [String] = ["Item1", "Item2", "Item3", "Item4", "Item5", "Item6"]
    
    // MARK: Важно выставить allowsMultipleSelection для множественного выбора
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout() 
        layout.scrollDirection = .vertical
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsVerticalScrollIndicator = false
        view.allowsMultipleSelection = true
        view.alwaysBounceVertical = true
        view.delegate = self
        view.dataSource = self
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    private func configureView() {
        title = "Главная"
        view.backgroundColor = .white
        collectionView.backgroundColor = .white
        
        collectionView.register(cellWithClass: ExpandableCell.self)
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

}

extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        collectionView.dequeueReusableCell(withClass: ExpandableCell.self, for: indexPath)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        3
    }
    
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    // MARK: Dynamic height calculation
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let isSelected = collectionView.indexPathsForSelectedItems?.contains(indexPath) ?? false
        
        sizingCell.frame = CGRect(
            origin: .zero,
            size: CGSize(width: collectionView.bounds.width - 40, height: 1000)
        )
        
        sizingCell.isSelected = isSelected
        sizingCell.setNeedsLayout()
        sizingCell.layoutIfNeeded()

        let size = sizingCell.systemLayoutSizeFitting(
            CGSize(width: collectionView.bounds.width - 40, height: .greatestFiniteMagnitude),
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .defaultLow
        )

        return size
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        24
    }
    
}

extension MainViewController: UICollectionViewDelegate {
    
    // MARK: Overriding the method for animated cell collapse
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        collectionView.deselectItem(at: indexPath, animated: true)
        collectionView.performBatchUpdates(nil)
        return true
    }
    
    // MARK: Переопределяем метод для анимированного разворачивания ячейки
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        collectionView.performBatchUpdates(nil)
        
        // MARK: Overriding the method for animated cell expansion
        DispatchQueue.main.async {
            guard let attributes = collectionView.collectionViewLayout.layoutAttributesForItem(at: indexPath) else {
                return
            }

            let desiredOffset = attributes.frame.origin.y - 20
            let contentHeight = collectionView.collectionViewLayout.collectionViewContentSize.height
            let maxPossibleOffset = contentHeight - collectionView.bounds.height
            let finalOffset = max(min(desiredOffset, maxPossibleOffset), 0)

            collectionView.setContentOffset(
                CGPoint(x: 0, y: finalOffset),
                animated: true
            )
            
            // MARK: This whole crutch can be easily replaced with:
            // collectionView.scrollToItem(at: indexPath, at: .top, animated: true)
            // But then there will be no 20 pixel inset on top (for beauty)
        }
        
        return true
    }
    
}

class BaseViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    var shouldHideNavigationBar = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(shouldHideNavigationBar, animated: true)
    }
    
}
