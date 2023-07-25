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
                    /*Async-Await*/
//                    Task {
//                        let todo = try await NetworkService.shared.createToDo(dto)
//                        print(todo.id)
//                        print(todo.title)
//                    }
                    
                    /*Completion Handler*/
//                    NetworkServiceWithCB.shared.createToDo(dto) { result in
//                        switch result {
//                            case .success(let todo):
//                                print(todo.id)
//                                print(todo.title)
//                            case .failure(let error):
//                                print(error)
//                        }
//                    }
                    
                    /*Alamofire*/
                    NetworkServiceWithAlamofire.shared.createToDo(dto) { result in
                        switch result {
                            case .success(let todo):
                                print(todo.id)
                                print(todo.title)
                            case .failure(let error):
                                print(error)
                        }
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
