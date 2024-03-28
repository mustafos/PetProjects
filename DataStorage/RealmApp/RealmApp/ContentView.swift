//
//  ContentView.swift
//  RealmApp
//
//  Created by Mustafa Bekirov on 17.12.2023.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    
    @ObservedResults(ShoppingList.self) var shoppingLists
    @State private var isPresented: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                if shoppingLists.isEmpty {
                    Text("No shopping lists!")
                }
                
                List {
                    ForEach(shoppingLists, id: \.id) { shoppingList in
                        NavigationLink {
                            ShoppingListItemsScreen(shoppingList: shoppingList)
                        } label: {
                            VStack(alignment: .leading) {
                                Text(shoppingList.title)
                                Text(shoppingList.address)
                                    .opacity(0.4)
                            }
                        }
                    }
                    .onDelete(perform: $shoppingLists.remove)
                }
                .navigationTitle("RealmApp")
            }
            .sheet(isPresented: $isPresented) {
                AddShoppingListScreen()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isPresented = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
