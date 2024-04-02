import SwiftUI
import UIKit

struct RootView: View {
    @ObservedObject var viewRouter: ViewRouter
    @ObservedObject var loginViewModel: LoginViewModel
    @ObservedObject var homeViewModel: HomeViewModel
    
    @State private var selectedIndex = 0
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(hex: 0x1F1D2B)
                    .ignoresSafeArea()
                VStack {
                    
                    if(selectedIndex == 0) { // Home
                        HomeView(homeViewModel: homeViewModel)
                    } else if (selectedIndex == 1) { // Search
                        SearchView()
                    } else if (selectedIndex == 2) { // Notification
                        NotificationView()
                    } else if (selectedIndex == 3) { // Profile
                        ProfileView()
                    }
                }
                VStack (spacing: 0) {
                    Spacer()
                    if(selectedIndex == 0 || selectedIndex == 3) {
                        HStack {
                            Spacer()
                            NavigationLink(destination: NewPostView(viewRouter: viewRouter, newPostViewModel: NewPostViewModel(), loginViewModel: loginViewModel)) {
                                Image(systemName: "plus")
                                    .font(.title.weight(.semibold))
                                    .padding()
                                    .background(Color(hex: 0x566197))
                                    .foregroundColor(.white)
                                    .clipShape(Circle())
                                    .shadow(radius: 4, x: 0, y: 4)
                            }
                            .padding(10)
                        }
                    }
                    CustomTabBar(selectedIndex: $selectedIndex)
                }
            }
            .navigationBarTitle("Back", displayMode: .inline)
            .navigationBarHidden(true)
        }
        
    }
    
}

// 커스텀 탭바
struct CustomTabBar: View {
    @Binding var selectedIndex: Int
    
    var body: some View {
            HStack {
                Spacer().frame(width: 10)
                TabBarButton(index: 0, imageName: "house", selectedIndex: $selectedIndex)
                Spacer()
                TabBarButton(index: 1, imageName: "magnifyingglass", selectedIndex: $selectedIndex)
                Spacer()
                TabBarButton(index: 2, imageName: "bell", selectedIndex: $selectedIndex)
                Spacer()
                TabBarButton(index: 3, imageName: "person", selectedIndex: $selectedIndex)
                Spacer().frame(width: 10)
            }
            .padding()
            .background(Color(hex: 0x252836))
            .foregroundColor(.white)
        
    }
}

struct TabBarButton: View {
    let index: Int
    let imageName: String
    @Binding var selectedIndex: Int
    
    var body: some View {
        Button(action: {
            selectedIndex = index
        }) {
            VStack {
                Image(systemName: imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
            }
            .padding(.top, 4)
            .padding(.horizontal, 20)
            .foregroundColor(selectedIndex == index ? .white : .white.opacity(0.3))
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        let loginViewModel = LoginViewModel()
        loginViewModel.username = "user1"
        loginViewModel.isLoggedIn = true
        
        return RootView(viewRouter: ViewRouter(), loginViewModel: loginViewModel, homeViewModel: HomeViewModel())
    }
}

