import SwiftUI

struct LoginView: View {
    @ObservedObject var viewRouter: ViewRouter
    @ObservedObject var loginViewModel: LoginViewModel
    
    @State private var showAlert = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(hex: 0x1F1D2B)
                    .ignoresSafeArea()
                VStack(spacing: 0) {
                    Spacer().frame(height: 50)
                    Text("Re:verb")
                        .font(Font.custom("Shalimar", size: 80))
                        .frame(height: geometry.size.height * 0.35)
                        .foregroundColor(.white)
                    VStack (alignment: .leading){
                        Text("이메일")
                            .font(Font.custom("Pretendard-Regular", size: 16))
                            .foregroundColor(.white)
                        TextField("", text: $loginViewModel.username, prompt: Text("Enter your email").foregroundColor(.white.opacity(0.15)))
                            .font(Font.custom("Pretendard-Regular", size: 14))
                            .frame(height: 20)
                            .padding()
                            .background(Color(hex: 0x3B3654))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                        Spacer().frame(height: 14)
                        Text("비밀번호")
                            .font(Font.custom("Pretendard-Regular", size: 16))
                            .foregroundColor(.white)
                        SecureField("", text: $loginViewModel.password, prompt: Text("Enter your password").foregroundColor(.white.opacity(0.15)))
                            .font(Font.custom("Pretendard-Regular", size: 14))
                            .frame(height: 20)
                            .padding()
                            .background(Color(hex: 0x3B3654))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    Spacer().frame(height: 55)
                    VStack {
                        Button(action: {
                            loginViewModel.login()
                        }) {
                            Text("로그인")
                                .font(Font.custom("Pretendard-Light", size: 20))
                                .frame(maxWidth: .infinity)
                                .frame(height: 25)
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .background(Color(hex: 0x566197))
                                .cornerRadius(8)
                        }
                        Spacer().frame(height: 14)
                        HStack {
                            Text("아직 계정이 없으신가요?")
                                .font(Font.custom("Pretendard-Light", size: 14))
                                .foregroundColor(.white)
                            Text("회원가입")
                                .font(Font.custom("Pretendard-Bold", size: 14))
                                .foregroundColor(Color(hex: 0x566197))
                        }
                        
                    }
                    Spacer()
                }
                .padding(.horizontal, 30)
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("로그인 실패"), message: Text(loginViewModel.errorMessage), dismissButton: .default(Text("확인")))
            }
            .onReceive(loginViewModel.$isLoggedIn) { isLoggedIn in
                if isLoggedIn {
                    viewRouter.goTo(.Root)
                }
            }
            .onReceive(loginViewModel.$errorMessage) { errorMessage in
                if !errorMessage.isEmpty {
                    showAlert = true
                }
            }
            
        }
        
        
//        VStack {
//            TextField("Username", text: $loginViewModel.username)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding()
//            
//            SecureField("Password", text: $loginViewModel.password)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding()
//            
//            Button("Login") {
//                viewModel.login()
//            }
//            .padding()
//            
//            if viewModel.isLoggedIn {
//                Text("Login successful")
//                    .foregroundColor(.green)
//            } else if !viewModel.errorMessage.isEmpty {
//                Text(viewModel.errorMessage)
//                    .foregroundColor(.red)
//            }
//        }
//        .padding()
    }
}
