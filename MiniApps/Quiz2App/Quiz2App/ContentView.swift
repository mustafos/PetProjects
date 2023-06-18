import SwiftUI

struct ContentView: View {
    
    @StateObject var manager = QuizManager()
    @State var showStart = false
    @State var showResults = false
    
    var body: some View {
        TabView {
            ForEach(manager.questions.indices, id: \.self) { index in
                VStack {
                    Spacer()
                    QuestionView(question: $manager.questions[index])
                    Spacer()
                    
                    if let lastQuestion = manager.questions.last, lastQuestion.id == manager.questions[index].id {
                        
                        Button {
                            print("OK")
                        } label: {
                            Text("Submit")
                                .padding()
                                .foregroundColor(.white)
                                .background(
                                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                                        .fill(Color("AppColor"))
                                        .frame(width: 340)
                                )
                        }
                        .buttonStyle(.plain)
                        .disabled(!manager.canSubmitQuiz())
                    }
                }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .fullScreenCover(isPresented: $showStart) {
            StartView()
        }
        .fullScreenCover(isPresented: $showResults) {
            ResultsView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
