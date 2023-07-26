import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            VStack {
                Text("I am doing just fine")
                    .padding()
                Text("text verticaly")
                    .padding(.vertical)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
