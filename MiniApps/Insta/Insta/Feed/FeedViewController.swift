//
//  FeedViewController.swift
//  Insta
//
//  Created by Mustafa Bekirov on 12.04.2023.
//
import SnapKit
import UIKit

class FeedViewController: UIViewController {
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }

    // MARK: - Private properties
    private let tableView = UITableView()
    private var items: [FeedItemType] = [
        .stories([
            FeedStoriesItemCellInfo(image: UIImage(named: "ava1")!, username: "mustafos", isAddButtonVisible: true, isNewStory: false),
            FeedStoriesItemCellInfo(image: UIImage(named: "ava2")!, username: "jobs", isAddButtonVisible: false, isNewStory: true),
            FeedStoriesItemCellInfo(image: UIImage(named: "ava3")!, username: "einstein", isAddButtonVisible: false, isNewStory: true),
            FeedStoriesItemCellInfo(image: UIImage(named: "ava4")!, username: "sparrow", isAddButtonVisible: false, isNewStory: true),
            FeedStoriesItemCellInfo(image: UIImage(named: "ava5")!, username: "tutankhamun", isAddButtonVisible: false, isNewStory: true),
            FeedStoriesItemCellInfo(image: UIImage(named: "ava6")!, username: "spiderman", isAddButtonVisible: false, isNewStory: false),
            FeedStoriesItemCellInfo(image: UIImage(named: "ava7")!, username: "batman", isAddButtonVisible: false, isNewStory: false)
        ]),
        .post(FeedPostItemInfo(userImage: UIImage(named: "ava5")!, username: "tutankhamun", postSubtitle: "I am on a seafood diet. I see food, and I eat it.", postImage: UIImage(named: "seafood")!, numberOfLikes: 1341, comment: CommentShortInfo(username: "sparrow", commentText: "I love seafood to!"))),
        .post(FeedPostItemInfo(userImage: UIImage(named: "ava7")!, username: "batman", postSubtitle: "P-A-R-T-Y!! Let's goo!!", postImage: UIImage(named: "dance")!, numberOfLikes: 1939, comment: CommentShortInfo(username: "jobs", commentText: "Here’s to the nights we don’t remember and the friends we won’t forget"))),
        .post(FeedPostItemInfo(userImage: UIImage(named: "ava4")!, username: "sparrow", postSubtitle: "New Image", postImage: UIImage(named: "hair-cut")!, numberOfLikes: 2003, comment: CommentShortInfo(username: "batman", commentText: "OMG! I love what your hair is doing today"))),
        .post(FeedPostItemInfo(userImage: UIImage(named: "ava3")!, username: "einstein", postSubtitle: "The theory of relativity", postImage: UIImage(named: "man")!, numberOfLikes: 1947, comment: CommentShortInfo(username: "jobs", commentText: "#Inspirational")))
    ]
}

// MARK: - Private methods
private extension FeedViewController {
    func initialize() {
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .black
        navigationItem.leftBarButtonItems = makeLeftBarButtonItems()
        navigationItem.rightBarButtonItems = makeRightBarButtonItems()
        tableView.dataSource = self
        tableView.separatorColor = .clear
        tableView.register(FeedStoriesSetCell.self, forCellReuseIdentifier: String(describing: FeedStoriesSetCell.self))
        tableView.register(FeedPostCell.self, forCellReuseIdentifier: String(describing: FeedPostCell.self))
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func makeLeftBarButtonItems() -> [UIBarButtonItem] {
        let logoBarButtonItem = UIBarButtonItem(customView: LogoView())
        let dropDownButtonItem = UIBarButtonItem(title: nil, image: UIImage(systemName: "chevron.down"), target: self, action: nil, menu: makeDropDownMenu())
        return [logoBarButtonItem, dropDownButtonItem]
    }

    func makeRightBarButtonItems() -> [UIBarButtonItem] {
        let addBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.app"), style: .plain, target: self, action: #selector(didTapPlusButton))
        let directBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "paperplane"), style: .plain, target: self, action: #selector(didTapDirectButton))
        return [directBarButtonItem, addBarButtonItem]
    }

    @objc func didTapPlusButton() {
        print("Add")
    }

    @objc func didTapDirectButton() {
        print("Direct")
    }

    func makeDropDownMenu() -> UIMenu {
        let subsItem = UIAction(title: "Subscription", image: UIImage(systemName: "person.2")) { _ in
            print("Subs")
        }
        let favsItem = UIAction(title: "Favorites", image: UIImage(systemName: "star")) { _ in
            print("Favorites")
        }
        return UIMenu(title: "", children: [subsItem, favsItem])
    }
}

// MARK: - UITableViewDataSource
extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        switch item {
        case .stories(let info):
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FeedStoriesSetCell.self), for: indexPath) as! FeedStoriesSetCell
            cell.configure(with: info)
            return cell
        case .post(let post):
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FeedPostCell.self), for: indexPath) as! FeedPostCell
            cell.configure(with: post)
            return cell
        }
    }
}
