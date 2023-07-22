import SwiftUI

struct ContentView: View {
    
    @State private var user: UserResults.User?
    var body: some View {
        HStack {
            Image(systemName: "globe")
                .resizable()
                .frame(width: 80, height: 80)
                .imageScale(.large)
                .foregroundColor(.accentColor)
            VStack(alignment: .leading) {
                Text("\(user?.name.first ?? "Name") \((user?.name.last ?? "Last name"))")
                    .font(.title2)
                    .bold()
                Text("\(user?.email ?? "email")")
                Text("Sex: \(user?.gender ?? "No")")
            }
        }
        .onAppear {
//            NetworkServiceWithCompletions.shared.fetchData { result in
//                switch result {
//                    case .success(let usersData):
//                        let user = usersData.results[0]
//                        self.user = user
//                    case .failure(let failure):
//                        print(failure.localizedDescription)
//                }
//            }
            Task {
                let result = try await NetworkServiceWithAsync.shared.fetchData()
                self.user = result.results[0]
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
