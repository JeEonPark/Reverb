import SwiftUI

struct ContentView: View {
    @StateObject var viewRouter: ViewRouter = ViewRouter()
    @StateObject var loginViewModel: LoginViewModel = LoginViewModel()
    @StateObject var homeViewModel: HomeViewModel = HomeViewModel()
    @StateObject var newPostViewModel: NewPostViewModel = NewPostViewModel()
    
    var body: some View {
        switch viewRouter.currentView {
        case .Login:
            LoginView(viewRouter: viewRouter, loginViewModel: loginViewModel)
        case .Root:
            RootView(viewRouter: viewRouter, loginViewModel: loginViewModel, homeViewModel: homeViewModel)
        case .NewPost:
            NewPostView(viewRouter: viewRouter, newPostViewModel: newPostViewModel, loginViewModel: loginViewModel)
        }
    }
}
