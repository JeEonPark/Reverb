import Foundation

class LoginViewModel: ObservableObject {
    private let userRepository = UserRepository()
    
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String = ""
    
    func login() {
        userRepository.authenticate(username: username, password: password) { result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self.isLoggedIn = success
                    if !success {
                        self.errorMessage = "이메일 비밀번호가 다릅니다."
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
