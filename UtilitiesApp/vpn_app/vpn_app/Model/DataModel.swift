//
//  DataModel.swift
//  vpn_app
//
//  Created by Mustafa Bekirov on 04.09.2024.
//

import Foundation

struct CountryModel: Identifiable {
    var id = UUID()
    var name: CountryFlags
    var flagImageName: CountryFlagsImage
    var isFavorite: Bool
    var isLock: Bool
    
    init(id: UUID = UUID(), name: CountryFlags, flagImageName: CountryFlagsImage, isFavorite: Bool, isLock: Bool) {
        self.id = id
        self.name = name
        self.flagImageName = flagImageName
        self.isFavorite = isFavorite
        self.isLock = isLock
    }
}

enum CountryFlags: String, CaseIterable {
    case usa = "USA"
    case germany = "Germany"
    case australia = "Australia"
    case azerbaijan = "Azerbaijan"
    case belgium = "Belgium"
    case brazil = "Brazil"
    case denmark = "Denmark"
    case france = "France"
    case netherlands = "Netherlands"
    case uk = "United Kingdom"
    case spain = "Spain"
    case italy = "Italy"
    case hungary = "Hungary"
    case norway = "Norway"
    case portugal = "Portugal"
    case russia = "Russia"
    case chile = "Chile"
    case ukraine = "Ukraine"
    case uruguay = "Uruguay"
}

enum CountryFlagsImage: String, CaseIterable {
    case usa
    case germany
    case australia
    case azerbaijan
    case belgium
    case brazil
    case denmark
    case france
    case netherlands
    case uk
    case spain
    case italy
    case hungary
    case norway
    case portugal
    case russia
    case chile
    case ukraine
    case uruguay
}
