//
//  CatalogInteractor.swift
//  Builder
//
//  Created by Mustafa Bekirov on 13.02.2023.
//

import Foundation

protocol Interactor {
    init(presenter: Presenter)
}

class CatalogInteractor: Interactor {
    var presenter: Presenter!
    
    // Bussines Logic
    required init(presenter: Presenter) {
        self.presenter = presenter
    }
}
