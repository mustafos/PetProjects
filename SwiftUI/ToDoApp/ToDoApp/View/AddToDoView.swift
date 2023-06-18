import SwiftUI
import CoreData

struct AddToDoView: View {
    
    // MARK: – PROPERTIES
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name: String = ""
    @State private var priority: String = "Normal"
    @State private var errorShowing: Bool = false
    @State private var errorTitle: String = ""
    @State private var errorMessage: String = ""
    
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
                        if self.name != "" {
                            let todo = Todo(context: self.managedObjectContext)
                            todo.name = self.name
                            todo.priority = self.priority
                            
                            do {
                                try self.managedObjectContext.save()
                            } catch {
                                print(error)
                            }
                        } else {
                            self.errorShowing = true
                            self.errorTitle = "Invalid Name"
                            self.errorMessage = "Make sure to enter something for\nthe new todo item."
                            return
                        }
                        self.presentationMode.wrappedValue.dismiss()
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
            })
            )
            .alert(isPresented: $errorShowing) {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        } // END: NAVIGATION
    }
}

// MARK: – PREVIEW
struct AddToDoView_Previews: PreviewProvider {
    static var previews: some View {
        AddToDoView()
    }
}
