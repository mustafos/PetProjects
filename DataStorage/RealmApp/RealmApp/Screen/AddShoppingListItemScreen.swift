//
//  AddShoppingListItemScreen.swift
//  RealmApp
//
//  Created by Mustafa Bekirov on 18.12.2023.
//

import SwiftUI
import RealmSwift

struct AddShoppingListItemScreen: View {
    
    @ObservedRealmObject var shoppingList: ShoppingList
    var itemToEdit: ShoppingItem?
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var title: String = ""
    @State private var quantity: String = ""
    @State private var selectedCategory: String = ""
    
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    let data = ["Produce", "Fruit", "Meet", "Condiments", "Beverages", "Snacks", "Dairy"]
    
    init(shoppingList: ShoppingList, itemToEdit: ShoppingItem? = nil) {
        self.shoppingList = shoppingList
        self.itemToEdit = itemToEdit
        
        if let itemToEdit = itemToEdit {
            _title = State(initialValue: itemToEdit.title)
            _quantity = State(initialValue: String(itemToEdit.quantity))
            _selectedCategory = State(initialValue: itemToEdit.category)
        }
    }
    
    private var isEditing: Bool {
        itemToEdit == nil ? false : true
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            
                if !isEditing {
                    Text("Add Item")
                        .font(.largeTitle)
                }
            
                LazyVGrid(columns: columns) {
                    ForEach(data, id: \.self) { item in
                        Text(item)
                            .padding()
                            .frame(width: 130)
                            .background(selectedCategory == item ? .orange : .green)
                            .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                            .foregroundStyle(.white)
                            .onTapGesture {
                                selectedCategory = item
                            }
                    }
                }
                Spacer().frame(height: 60)
                TextField("Title", text: $title)
                    .textFieldStyle(.roundedBorder)
                TextField("Quantity", text: $quantity)
                    .textFieldStyle(.roundedBorder)
                
                Button {
                    // save or update the item
                    if let _ = itemToEdit {
                        // update
                        update()
                    } else {
                        // save
                        save()
                    }
                    
                    dismiss()
                    
                } label: {
                    Text(isEditing ? "Update" : "Save")
                        .frame(maxWidth: .infinity, maxHeight: 40)
                }
                .buttonStyle(.bordered)
                .padding(.top, 20)
                Spacer()
                    .navigationTitle(isEditing ? "Update Item" : "Add Item")
            }
            .padding()
    }
    
    private func save() {
        let shopingItem = ShoppingItem()
        shopingItem.title = title
        shopingItem.quantity = Int(quantity) ?? 1
        shopingItem.category = selectedCategory
        $shoppingList.items.append(shopingItem)
    }
    
    private func update() {
        if let itemToEdit = itemToEdit {
            do {
                let realm = try Realm()
                guard let objectToUpdate = realm.object(ofType: ShoppingItem.self, forPrimaryKey: itemToEdit.id) else { return }
                try realm.write {
                    objectToUpdate.title = title
                    objectToUpdate.category = selectedCategory
                    objectToUpdate.quantity = Int(quantity) ?? 1
                }
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    AddShoppingListItemScreen(shoppingList: ShoppingList())
}
