import SwiftUI

struct ContentView: View {
    
    @State private var todos = [ToDo]()
    @State private var todoTitle = ""
    
    var body: some View {
        VStack {
            HStack {
                TextField("Enter a named new task", text: $todoTitle)
                Button("Create!") {
                    print("Created a new task")
                    let dto = ToDo.TodoDTO(userId: 5,
                                           title: todoTitle,
                                           completed: false)
                    Task {
                        let todo = try await NetworkService.shared.createToDo(dto)
                        print(todo.id)
                        print(todo.title)
                    }
                }
            }.padding()
            
            List {
                ForEach(todos) { todo in
                    Text(todo.title)
                }
            }
            .padding()
            .onAppear {
                Task {
                    let todos = try await NetworkService.shared.getAllTodos()
                    self.todos = todos
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
