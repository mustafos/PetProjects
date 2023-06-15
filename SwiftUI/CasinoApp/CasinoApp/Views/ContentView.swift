import SwiftUI

struct ContentView: View {
    
    // MARK: – PROPERTIES
    
    // MARK: – BODY
    var body: some View {
        ZStack {
            // Background
            LinearGradient(gradient: Gradient(colors: [Color("ColorPink"), Color("ColorPurple")]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            // Interface
            VStack(alignment: .center, spacing: 5) {
                
                // Header
                
                LogoView()
                
                Spacer()
                
                // Score
                HStack {
                    HStack {
                        Text("Your\nCoins".uppercased())
                            .scoreLabelStyle()
                            .multilineTextAlignment(.trailing)
                        
                        Text("100")
                            .scoreNumberStyle()
                            .modifier(ScoreNumberModifier())
                    }
                    .modifier(ScoreContainerModifier())
                    
                    Spacer()
                    
                    HStack {
                        Text("200")
                            .scoreNumberStyle()
                            .modifier(ScoreNumberModifier())
                        
                        Text("High\nScore".uppercased())
                            .scoreLabelStyle()
                            .multilineTextAlignment(.leading)
                    }
                    .modifier(ScoreContainerModifier())
                }
                
                // Slot machine
                // Footer
                
                Spacer()
            }
            // Buttons
            .overlay(
                // Rest
                Button(action: {
                    print("Reset the game")
                }, label: {
                    Image(systemName: "arrow.2.circlepath.circle")
                })
                .modifier(ButtonModifier()),
                alignment: .topLeading
            )
            .overlay(
                // Info
                Button(action: {
                    print("Info View")
                }, label: {
                    Image(systemName: "info.circle")
                })
                .modifier(ButtonModifier()),
                alignment: .topTrailing
            )
            .padding()
            .frame(maxWidth: 720)
            // POPUP
        } //: ZSTACK
    }
}

// MARK: – PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
