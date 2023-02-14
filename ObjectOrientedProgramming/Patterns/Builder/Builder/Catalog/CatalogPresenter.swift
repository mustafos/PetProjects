//
//  CatalogPresenter.swift
//  Builder
//
//  Created by Mustafa Bekirov on 13.02.2023.
//

import Foundation

protocol Presenter {
    var messageInfo: String {get}
}

class CatalogPresenter: Presenter {
    weak var viewController: CatalogViewController?
    
    var messageInfo = "Create viewModel for presentation"
}
