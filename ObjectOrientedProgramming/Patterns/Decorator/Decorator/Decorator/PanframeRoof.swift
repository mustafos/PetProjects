//
//  PanframeRoof.swift
//  Decorator
//
//  Created by Mustafa Bekirov on 16.02.2023.
//

import Foundation

class PanframeRoof: VolkswagenDecorator {
    required init(decorator: VolkswagenProtocol) {
        super.init(decorator: decorator)
    }
    
    override func getTitle() -> String {
        return super.getTitle() + "premium roof"
    }
    
    override func getPrice() -> Double {
        return super.getPrice() + 1500
    }
}
