//
//  CatalogBuilder.swift
//  Builder
//
//  Created by Mustafa Bekirov on 13.02.2023.
//

import UIKit

class CatalogBuilder: ModuleBuilder {
    var title : String?
    
    func setTitle(_ title: String) -> CatalogBuilder {
        self.title = title
        return self
    }
    
    func build() -> UIViewController {
        guard let title = title else { fatalError("You must add a title") }
        let presenter = CatalogPresenter()
        let interactor = CatalogInteractor(presenter: presenter)
        let controller = CatalogViewController(title: title, interactor: interactor)
        presenter.viewController = controller
        
        return controller
    }
    
    
}
