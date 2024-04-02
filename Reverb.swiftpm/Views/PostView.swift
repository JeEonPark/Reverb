import SwiftUI

struct PostView: View {
    @ObservedObject var postViewModel: PostViewModel
    @State private var imageData: Data?
    
    var body: some View {
        ZStack{
            Color(hex: 0x1F1D28)
                .ignoresSafeArea()
            VStack(spacing: 0) {
                ScrollView {
                    VStack {
                        ZStack {
                            if let imageData = imageData, let uiImage = UIImage(data: imageData) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(maxHeight: 200)
                                    .clipped()
                            } else {
                                Color.gray
                                    .frame(height: 200)
                                    .cornerRadius(8)
                            }
                            
                            Color.black.opacity(0.3)
                            VStack (alignment: .leading, spacing: 0){
                                Spacer()
                                HStack {
                                    Spacer()
                                    Button(action: {
                                        // 재생 버튼을 눌렀을 때의 동작 추가
                                    }) {
                                        Image(systemName: "play.circle.fill")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .font(.title)
                                            .foregroundColor(.white)
                                            .frame(width: 30, height: 30)
                                    }
                                }
                                
                            }
                            .padding(.vertical, 10)
                            .padding(.horizontal, 16)
                        }
                        HStack {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text(postViewModel.post.title)
                                        .font(Font.custom("Pretendard-Bold", size: 22))
                                        .foregroundColor(.white)
                                    Spacer()
                                    Text("from \(postViewModel.post.uploader)")
                                        .font(Font.custom("Pretendard-Light", size: 16))
                                        .foregroundColor(.white.opacity(0.8))
                                }
                                
                                Text(postViewModel.post.location)
                                    .font(Font.custom("Pretendard-Light", size: 16))
                                    .foregroundColor(.white.opacity(0.8))
                                
                            }
                            Spacer()
                            
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        
                        HStack {
                            Text(postViewModel.post.description)
                                .font(Font.custom("Pretendard-Light", size: 18))
                                .foregroundColor(.white.opacity(0.8))
                                .padding(.horizontal, 20)
                                .padding(.bottom, 20)
                            
                            Spacer()
                        }
                        Color.white.opacity(0.7).frame(height: 0.3)
                        HStack {
                            Text("Comments")
                                .font(Font.custom("Pretendard-Bold", size: 22))
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        ForEach(postViewModel.post.comments, id: \.self) { comment in
                            CommentView(comment: comment)
                        }
                    }
                }
            }
            VStack(spacing: 0) {
                Spacer()
                Color.white.opacity(0.7).frame(height: 1)
                    .padding(.bottom, 10)
                HStack {
                    Color.gray
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                    TextField("Type comment..", text: $postViewModel.title)
                        .foregroundColor(.white)
                        .frame(height: 14)
                        .padding()
                        .background(Color(hex: 0x3B3654))
                        .foregroundColor(.white)
                        .cornerRadius(100)
                        .padding(.horizontal, 5)
                    Button(action: {
                        // 재생 버튼을 눌렀을 때의 동작 추가
                    }) {
                        Image(systemName: "paperplane.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .font(.title)
                            .foregroundColor(.white)
                            .frame(width: 30, height: 30)
                    }
                    
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle("Post")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarTitleTextColor(.white)
        .onAppear() {
            loadImage()
        }
    }
        
    
    func loadImage() {
        postViewModel.fetchImage(for: postViewModel.post) { data in
            guard let data = data else { return }
            self.imageData = data
        }
    }
}

struct CommentView: View {
    let comment: Comment
    
    var body: some View {
        HStack {
            VStack {
                Color.gray
                    .frame(width: 35, height: 35)
                    .clipShape(Circle())
                Spacer()
            }
            VStack(alignment: .leading) {
                Text(comment.user)
                    .font(Font.custom("Pretendard-SemiBold", size: 16))
                    .foregroundColor(.white)
                    .padding(.bottom, 1)
                Text(comment.comment)
                    .font(Font.custom("Pretendard-Regular", size: 16))
                    .foregroundColor(.white)
            }
            
            Spacer()
        }
        .padding(.horizontal, 20)
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        let loginViewModel = LoginViewModel()
        loginViewModel.username = "user1"
        loginViewModel.isLoggedIn = true
        
        return RootView(viewRouter: ViewRouter(), loginViewModel: loginViewModel, homeViewModel: HomeViewModel())
    }
}

