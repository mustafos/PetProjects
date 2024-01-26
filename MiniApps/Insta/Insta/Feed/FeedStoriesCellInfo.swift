//
//  FeedStoriesCellInfo.swift
//  Insta
//
//  Created by Mustafa Bekirov on 12.04.2023.
//

import UIKit

struct FeedStoriesItemCellInfo {
    let image: UIImage
    let username: String
    let isAddButtonVisible: Bool
    let isNewStory: Bool
}

typealias FeedStoriesCellInfo = [FeedStoriesItemCellInfo]
