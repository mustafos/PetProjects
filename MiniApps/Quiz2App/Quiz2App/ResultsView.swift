import SwiftUI

struct ResultsView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var result: QuizResult
    
    var body: some View {
        VStack(spacing: 40) {
            Text("Quiz App")
                .font(.system(size: 64))
            
            Text("Results")
                .font(.system(size: 36))
            
            VStack(spacing: 10) {
                Text("\(result.correct) out of \(result.total)")
                    .font(.system(size: 32))
                
                Text(result.grade)
                    .font(.system(size: 24))
            }
            
            Text("Your completed the quiz!")
                .font(.system(size: 24))
            
            Button {
                dismiss()
            } label: {
                Text("Retake Quiz")
                    .padding()
                    .foregroundColor(.white)
                    .background(
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .fill(Color("AppColor"))
                            .frame(width: 340)
                    )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .padding(.bottom, 100)
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView(result: .init(correct: 8, total: 10, grade: "80%"))
    }
}
