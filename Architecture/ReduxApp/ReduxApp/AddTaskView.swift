//
//  AddTaskView.swift
//  ReduxApp
//
//  Created by Mustafa Bekirov on 03.01.2025.
//

import SwiftUI

struct AddTaskView: View {
    
    @EnvironmentObject var store: Store<AppState>
    @State private var name: String = ""
    
    struct Props {
        // props
        let tasks: [Task]
        // dispatch
        let onTaskAdded: (Task) -> ()
    }
    
    private func map(state: TaskState) -> Props {
        return Props(tasks: state.tasks, onTaskAdded: { task in
            store.dispatch(action: AddTaskAction(task: task))
        })
    }
    
    var body: some View {
        let props = map(state: store.state.taskState)
        
        return VStack {
            TextField("Enter task", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button("Add") {
                let task = Task(title: self.name)
                props.onTaskAdded(task)
            }
            
            List(props.tasks, id: \.id) { task in Text(task.title)
            }
            
            Spacer()
        }.padding()
    }
}

#Preview {
    let store = Store(reducer: appReducer, state: AppState())
    return AddTaskView().environmentObject(store)
}
