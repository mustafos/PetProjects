import SwiftUI

struct Question: Identifiable, Decodable {
    let id: Int
    let createdAt: String
    let title: String
    let answer: String
    let options: [String]
    var selection: String?
}

struct QuestionView: View {
    
    @Binding var question: Question
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(question.title)
            
            ForEach(question.options, id:\.self) { option in
                HStack {
                    Button {
                        question.selection = option
                    } label: {
                        if question.selection == option {
                            Circle()
                                .shadow(radius: 3)
                                .frame(width: 24, height: 24)
                                .foregroundColor(Color("AppColor"))
                        } else {
                            Circle()
                                .stroke()
                                .shadow(radius: 3)
                                .frame(width: 24, height: 24)
                        }
                    }
                    Text(option)
                }
            }
        }
        .foregroundColor(Color(uiColor: .secondaryLabel))
        .padding(.horizontal, 20)
        .frame(minWidth: 340, idealWidth: 550, alignment: .leading)
        .frame(height: 550)
        .background(Color(uiColor: .systemGray6))
        .cornerRadius(20)
        .shadow(color: Color(uiColor: .label).opacity(0.2), radius: 10)
    }
}
