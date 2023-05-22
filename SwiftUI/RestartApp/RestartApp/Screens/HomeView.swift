import SwiftUI

struct HomeView: View {
    // MARK: – PROPERTY
    @AppStorage("onboarding") var isOnboardingViewAction: Bool = false
    
    // MARK: – BODY
    var body: some View {
        VStack(spacing: 20) {
            Text("Home")
                .font(.largeTitle)
            
            Button {
                isOnboardingViewAction = true
            } label: {
                Text("Restart")
            }
        } //: VSTACK
    }
}

// MARK: – PREVIEW
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
