import SwiftUI

struct ContentView: View {
    
    // MARK: – CONTENT
    
    var body: some View {
        ScrollView() {
            HStack(alignment: .center, spacing: 20) {
                ForEach(0..<6) { item in
                    CardView()
                }
            }
            .padding(20)
        }
    }
}

// MARK: – PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
