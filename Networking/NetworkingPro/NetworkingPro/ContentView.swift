import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .onAppear {
            NetworkServiceWithCompletions.shared.fetchData { result in
                switch result {
                    case .success(let usersData):
                        print("Data: \(usersData.results[0].email)")
                    case .failure(let failure):
                        print(failure.localizedDescription)
                }
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
