//
//  StateLinesMemento.swift
//  Memento
//
//  Created by Mustafa Bekirov on 19.02.2023.
//

import Foundation

class StateLinesMemento {
    var linesArray: [LineModel]
    
    init(lines: [LineModel]) {
        self.linesArray = lines
    }
}
