import SwiftUI

struct ContentView: View {
    
    // MARK: – PROPERTIES
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State private var showingAddTodoView: Bool = false
    
    // MARK: – BODY
    var body: some View {
        NavigationView {
            List(0 ..< 5) { item in
                Text("Hello")
            } //: LIST
            .navigationBarTitle("ToDo", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                self.showingAddTodoView.toggle()
            }, label: {
                Image(systemName: "plus")
            }) //: ADD BUTTON
                .sheet(isPresented: $showingAddTodoView) {
                    AddToDoView().environment(\.managedObjectContext, self.managedObjectContext)
                }
            )
        } //: NAVIGATION
    }
}

// MARK: – PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
