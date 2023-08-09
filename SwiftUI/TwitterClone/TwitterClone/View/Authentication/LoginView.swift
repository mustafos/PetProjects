import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    var body: some View {
        ZStack {
            VStack {
                Image("TwitterLogo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 220, height: 100)
                    .padding(.top, 88)
                    .padding(.bottom, 32)
                
                VStack(spacing: 20) {
                    CustomTextField(text: $email, placeholder: Text("Email"), imageName: "envelope")
                        .padding()
                        .background(Color(.init(white: 1, alpha: 0.15)))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                    
                    CustomSecureField(text: $password, placeholder: Text("Password"))
                        .padding()
                        .background(Color(.init(white: 1, alpha: 0.15)))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 32)
                
                HStack {
                    Spacer()
                    
                    Button {
                        print("forgotPassword")
                    } label: {
                        Text("Forgot Password?")
                            .font(.footnote)
                            .bold()
                            .foregroundColor(.white)
                            .padding(.top, 16)
                            .padding(.trailing, 32)
                    }
                }
                
                Button {
                    print("signIn")
                } label: {
                    Text("Sign In")
                        .font(.headline)
                        .foregroundColor(.blue)
                        .frame(width: 360, height: 50)
                        .background(Color.white)
                        .cornerRadius(25)
                        .clipShape(Capsule())
                        .padding()
                }
                
                Spacer()
                
                HStack {
                    Text("Don't have an account?")
                        .font(.system(size: 14))
                    
                    Text("Sign Up")
                        .font(.system(size: 14, weight: .semibold))
                }
                .foregroundColor(.white)
                .padding(.bottom, 40)
            }
        }
        .background(Color(.blue))
        .ignoresSafeArea()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
