import SwiftUI

struct HomeView: View {
    @ObservedObject var homeViewModel: HomeViewModel
    @State private var todayFollowIndex = 0
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Text("Re:verb")
                        .font(Font.custom("Shalimar", size: 40))
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.horizontal, 30)
                HStack {
                    Button(action: {
                        todayFollowIndex = 0
                    }) {
                        Text("Today")
                            .font(Font.custom("Pretendard", size: 17))
                            .foregroundColor(todayFollowIndex == 0 ? .white : .white.opacity(0.4))
                            .overlay(
                                Rectangle()
                                    .frame(height: 2)
                                    .padding(.top, 5)
                                    .foregroundColor(todayFollowIndex == 0 ? .white : .clear)
                                    .offset(y: 14)
                            )
                            .offset(y: -5)
                    }
                    Spacer().frame(width: 20)
                    Button(action: {
                        todayFollowIndex = 1
                    }) {
                        Text("Follow")
                            .font(Font.custom("Pretendard", size: 17))
                            .foregroundColor(todayFollowIndex == 1 ? .white : .white.opacity(0.4))
                            .overlay(
                                Rectangle()
                                    .frame(height: 2)
                                    .padding(.top, 5)
                                    .foregroundColor(todayFollowIndex == 1 ? .white : .clear)
                                    .offset(y: 14)
                            )
                            .offset(y: -5)
                    }
                }
                
            }
            .padding(.bottom, 1)
            ScrollView (showsIndicators: false) {
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("최근 게시물")
                            .font(Font.custom("Pretendard-Bold", size: 22))
                            .foregroundColor(.white)
                        Spacer()
                    }
                    ForEach(homeViewModel.posts, id: \.id) { post in
                        CustomListItem(post: post, homeViewModel: homeViewModel)
                            .padding(.vertical, 6)
                    }
                    Spacer().frame(height: 170)
                }
            }
            .padding(.horizontal, 24)
            .scrollContentBackground(.hidden)
            .onAppear {
                homeViewModel.fetchRecentPosts()
            }
        }
    }
}

struct CustomListItem: View {
    let post: Post
    let homeViewModel: HomeViewModel
    @State private var imageData: Data?
    
    
    var body: some View {
        NavigationLink(destination: PostView(postViewModel: PostViewModel(post: post))) {
            ZStack {
                if let imageData = imageData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .cornerRadius(8)
                        .frame(height: 160)
                } else {
                    Color.gray
                        .frame(height: 160)
                        .cornerRadius(8)
                }
                Color.black.opacity(0.3)
                VStack (alignment: .leading, spacing: 0){
                    Spacer()
                    Text(post.title)
                        .font(Font.custom("Pretendard-Bold", size: 22))
                        .foregroundColor(.white)
                    HStack {
                        Text(post.location)
                            .font(Font.custom("Pretendard-Light", size: 14))
                            .foregroundColor(.white.opacity(0.8))
                        Spacer()
                        Text(post.duration)
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
            .onAppear() {
                loadImage()
            }
        }
    }
    
    func loadImage() {
        homeViewModel.fetchImage(for: post) { data in
            guard let data = data else { return }
            self.imageData = data
        }
    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        let viewModel = HomeViewModel()
//        viewModel.posts = [
//            Post(id: 1, title: "Flight to Jeju 🍊", location: "Jeju Island, Korea", photo_path: "jeju", sound_path: "", description: "", duration: "01:20", upload_datetime: Date(), comments: [], likes: 0),
//            Post(id: 2, title: "에노덴과 바다", location: "鎌倉高校前, Japan", photo_path: "japan", sound_path: "", description: "", duration: "02:00", upload_datetime: Date(), comments: [], likes: 0),
//            Post(id: 3, title: "Travel Town Street", location: "Los Angeles, CA", photo_path: "la", sound_path: "", description: "", duration: "01:40", upload_datetime: Date(), comments: [], likes: 0)
//        ]
//        return HomeView(homeViewModel: viewModel)
//    }
//}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let loginViewModel = LoginViewModel()
        loginViewModel.username = "user1"
        loginViewModel.isLoggedIn = true
        
        return RootView(viewRouter: ViewRouter(), loginViewModel: loginViewModel, homeViewModel: HomeViewModel())
    }
}

