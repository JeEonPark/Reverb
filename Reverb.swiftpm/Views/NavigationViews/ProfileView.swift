import SwiftUI

struct ProfileView: View {
    
    var body: some View {
        ZStack {
            VStack {
                Image("back")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxHeight: 200)
                    .clipped()
                Spacer()
            }
            .ignoresSafeArea()
            ScrollView {
                ZStack {
                    Color(hex: 0x1F1D28)
                        .padding(.top, 135)
                    VStack {
                        Image("profile")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 100)
                            .clipShape(Circle())
                            .padding(.top, 90)
                        Text("Jonny")
                            .font(.custom("Pretendard-Bold", size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text("Following 8 | Followers 10")
                            .font(.custom("Pretendard-Light", size: 16))
                            .foregroundColor(.white.opacity(0.7))
                        HStack {
                            Text("내가 올린 게시글")
                                .font(Font.custom("Pretendard-Bold", size: 18))
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal, 24)
                        CustomListItemCustom(title: "test", location: "test", duration: "01:00")
                            .padding(.horizontal, 24)
                        CustomListItemCustom(title: "test", location: "test", duration: "01:00")
                            .padding(.horizontal, 24)
                        CustomListItemCustom(title: "test", location: "test", duration: "01:00")
                            .padding(.horizontal, 24)
                        CustomListItemCustom(title: "test", location: "test", duration: "01:00")
                            .padding(.horizontal, 24)
                        Spacer().frame(height: 170)
                        Spacer()
                    }
                }
            }
        }
    }
}

struct CustomListItemCustom: View {
    let title: String
    let location: String
    let duration: String

    @State private var imageData: Data?
    
    
    var body: some View {
        ZStack {
            Color.gray
                .frame(height: 160)
                .cornerRadius(8)
            
            Color.black.opacity(0.3)
            VStack (alignment: .leading, spacing: 0){
                Spacer()
                Text(title)
                    .font(Font.custom("Pretendard-Bold", size: 22))
                    .foregroundColor(.white)
                HStack {
                    Text(location)
                        .font(Font.custom("Pretendard-Light", size: 14))
                        .foregroundColor(.white.opacity(0.8))
                    Spacer()
                    Text(duration)
                        .font(Font.custom("Pretendard-Medium", size: 12))
                        .foregroundColor(.white)
                        .padding(.horizontal, 9)
                        .padding(.vertical, 4)
                        .background(Color.black.opacity(0.6))
                        .cornerRadius(4)
                }
                
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 16)
            
        }
        .cornerRadius(8)
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        return ProfileView()
    }
}

struct ProfileView_PreViews_2: PreviewProvider {
    static var previews: some View {
        let loginViewModel = LoginViewModel()
        loginViewModel.username = "user1"
        loginViewModel.isLoggedIn = true
        
        return RootView(viewRouter: ViewRouter(), loginViewModel: loginViewModel, homeViewModel: HomeViewModel())
    }
}

