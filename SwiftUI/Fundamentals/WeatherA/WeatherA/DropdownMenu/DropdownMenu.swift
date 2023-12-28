//
//  DropdownMenu.swift
//  WeatherA
//
//  Created by Mustafa Bekirov on 27.12.2023.
//

import SwiftUI

struct DropMenu: Identifiable {
    var id = UUID()
    var title: String
}
let drop = [
    DropMenu(title: "Item 1"),
    DropMenu(title: "Item 2"),
    DropMenu(title: "Item 3"),
    DropMenu(title: "Item 4"),
    DropMenu(title: "Item 5"),
    DropMenu(title: "Item 6")
]

struct DropdownMenu: View {
    @State var show: Bool = true
    @State var name: String = "Item 1"
    
    var body: some View {
        DropTow()
    }
}

#Preview {
    DropdownMenu()
}
