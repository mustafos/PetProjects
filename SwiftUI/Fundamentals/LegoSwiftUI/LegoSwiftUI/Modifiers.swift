import SwiftUI

// Onboarding | Main
struct BackgroundMainView: View {
    var body: some View {
        ContainerRelativeShape()
            .fill(LinearGradient(colors: [.red, .blue], startPoint: .top, endPoint: .bottom))
            .ignoresSafeArea()
    }
}

// MARK: COLORS

struct GradientsColor {
    static let frostingToDuskGradient = LinearGradient(
        colors: [.red, .blue],
        startPoint: .top,
        endPoint: .bottom
    )
}

import SwiftUI

enum CustomModifierType {
    case title
    case button
    case symbol
}

struct CustomModifier: ViewModifier {
    var type: CustomModifierType
    
    func body(content: Content) -> some View {
        switch type {
        case .title:
            return AnyView(content
                            .font(.largeTitle)
                            .foregroundColor(Color.pink))
        case .button:
            return AnyView(content
                            .font(.headline)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(Capsule().fill(LinearGradient(colors: [.green, .yellow], startPoint: .bottomLeading, endPoint: .topTrailing)))
                            .foregroundColor(Color.white))
        case .symbol:
            return AnyView(content
                            .foregroundColor(Color.white)
                            .font(.system(size: 128))
                            .shadow(color: Color(UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)), radius: 12, x: 0, y: 0))
        }
    }
}

extension View {
    func customModifier(_ type: CustomModifierType) -> some View {
        self.modifier(CustomModifier(type: type))
    }
}

// TODO: – Example usage in a SwiftUI view
//struct ContentView: View {
//    var body: some View {
//        VStack(spacing: 20) {
//            Text("Hello, World!")
//                .customModifier(.title)
//
//            Button(action: {
//                print("Button tapped")
//            }) {
//                Text("Tap Me")
//            }
//            .customModifier(.button)
//
//            Image(systemName: "star.fill")
//                .customModifier(.symbol)
//        }
//        .padding()
//    }
//}
