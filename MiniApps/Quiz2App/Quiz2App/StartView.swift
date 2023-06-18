import SwiftUI

struct StartView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        
        VStack {
            Text("Quiz App")
                .font(.system(size: 64))
            Text("Are you ready to start the quiz?!?")
                .font(.system(size: 24))
            
            Button {
                dismiss()
            } label: {
                Text("Start")
                    .padding()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.top)
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
