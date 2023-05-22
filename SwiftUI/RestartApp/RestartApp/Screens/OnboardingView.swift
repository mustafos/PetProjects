import SwiftUI

struct OnboardingView: View {
    // MARK: – PROPERTY
    @AppStorage("onboarding") var isOnboardingViewAction: Bool = true
    
    // MARK: – BODY
    var body: some View {
        VStack(spacing: 20) {
            Text("Onboarding")
                .font(.largeTitle)
            
            Button {
                isOnboardingViewAction = false
            } label: {
                Text("Start")
            }
        } //: VSTACK
    }
}

// MARK: – PREVIEW
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
