//
//  NewNavigationStackView.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 09.06.2024.
//

import SwiftUI

struct CarBrand: Identifiable, Hashable {
    let name: String
    let id = NSUUID().uuidString
}

struct Car: Identifiable, Hashable {
    let id = NSUUID().uuidString
    let make: String
    let model: String
    let year: Int
    
    var description: String {
        return "\(year) • \(make) • \(model)"
    }
}

struct NewNavigationStackView: View {
    let brands: [CarBrand] = [
        .init(name: "Ferrari"),
        .init(name: "Porsche"),
        .init(name: "BMW"),
        .init(name: "Ford")
    ]
    
    let cars: [Car] = [
        .init(make: "Ferrari", model: "Spider", year: 2019),
        .init(make: "Porsche", model: "911", year: 2023),
        .init(make: "BMW", model: "Roadster", year: 2020),
        .init(make: "Ford", model: "Mustang", year: 2024)
    ]
    
    @State private var navigationPath = [CarBrand]()
    @State private var showFullStack: Bool = false
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack {
                List {
                    Section("Manufacturers") {
                        ForEach(brands) { brand in
                            NavigationLink(value: brand) {
                                Text(brand.name)
                            }
                        }
                    }
                    
                    Section("Cars") {
                        ForEach(cars) { car in
                            NavigationLink(value: car) {
                                Text(car.description)
                            }
                        }
                    }
                }
                .navigationDestination(for: CarBrand.self) { brand in
                    VStack {
                        viewForBrand(brand)
                        
                        Button {
                            navigationPath = []
                        } label: {
                            Text("Go to root")
                        }
                    }
                }
                .navigationDestination(for: Car.self) { car in
                    Color(.systemRed)
                }
                
                Button {
                    showFullStack.toggle()
                    
                    if showFullStack {
                        navigationPath = brands
                    } else {
                        navigationPath = [brands[0], brands[2], brands[1]]
                    }
                } label: {
                    Text("View all")
                }
            }
        }
    }
    
    func viewForBrand(_ brand: CarBrand) -> AnyView {
        switch brand.name {
        case "Ferrari":
            return AnyView(Color(.systemRed))
        case "Porsche":
            return AnyView(Color(.systemOrange))
        case "BMW":
            return AnyView(Color(.black))
        case "Ford":
            return AnyView(Color(.systemBlue))
        default:
            return AnyView(Color(.systemGray))
        }
    }
}

#Preview {
    NewNavigationStackView()
}
