import SwiftUI

struct AddToDoView: View {
    
    // MARK: – PROPERTIES
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name: String = ""
    @State private var priority: String = "Normal"
    
    let priorities = ["High", "Normal", "Low"]
    
    // MARK: – BODY
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    // MARK: – TODO NAME
                    TextField("ToDo", text: $name)
                    
                    // MARK: – TODO PRIORITY
                    Picker("Priority", selection: $priority) {
                        ForEach(priorities, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    // MARK: – SAVE BUTTON
                    Button {
                        print("Save a new todo item.")
                    } label: {
                        Text("Save")
                    } //: SAVE BUTTON
                } //: FORM
                Spacer()
            } //: VSTACK
            .navigationBarTitle("New Todo", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "xmark")
            }))
        } // END: NAVIGATION
    }
}

// MARK: – PREVIEW
struct AddToDoView_Previews: PreviewProvider {
    static var previews: some View {
        AddToDoView()
    }
}
