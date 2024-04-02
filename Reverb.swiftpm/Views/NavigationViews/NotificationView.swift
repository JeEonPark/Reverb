import SwiftUI

struct NotificationView: View {
    
    var body: some View {
        
        VStack(spacing: 0) {
            HStack {
                Text("Notification")
                    .font(Font.custom("Pretendard-Bold", size: 22))
                    .foregroundColor(.white)
                Spacer()
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 24)
            ScrollView {
                NotificationItemView(
                    profileImage: Image(systemName: "person.circle.fill"),
                    notificationMessage: "Senny님이 댓글을 달았습니다.",
                    date: "1 hour ago"
                )
                Divider().background(Color.white.opacity(0.3))
                NotificationItemView(
                    profileImage: Image(systemName: "person.circle.fill"),
                    notificationMessage: "Zero님이 내 게시글을 좋아합니다.",
                    date: "2 hours ago"
                )
                Divider().background(Color.white.opacity(0.3))
                NotificationItemView(
                    profileImage: Image(systemName: "person.circle.fill"),
                    notificationMessage: "Norang님이 내 게시글을 좋아합니다.",
                    date: "3 hours ago"
                )
                Divider().background(Color.white.opacity(0.3))
                // Adding 3 more sample notifications
                NotificationItemView(
                    profileImage: Image(systemName: "person.circle.fill"),
                    notificationMessage: "Erwin님이 댓글을 달았습니다.",
                    date: "4 hours ago"
                )
                Divider().background(Color.white.opacity(0.3))
                // Adding 3 more sample notifications
                NotificationItemView(
                    profileImage: Image(systemName: "person.circle.fill"),
                    notificationMessage: "Erwin님이 내 게시글을 좋아합니다.",
                    date: "4 hours ago"
                )
            }
        }
    }
}

struct NotificationItemView: View {
    let profileImage: Image
    let notificationMessage: String
    let date: String
    
    var body: some View {
        HStack(spacing: 16) {
            profileImage
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 40, height: 40)
                .clipShape(Circle())
                .foregroundColor(.white)
            VStack(alignment: .leading, spacing: 4) {
                Text(notificationMessage)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text(date)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
            }
            
            Spacer()
        }
        .padding(12)
        .background(Color.clear)
        .cornerRadius(10)
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        return NotificationView()
    }
}

struct NotificationView_PreViews_2: PreviewProvider {
    static var previews: some View {
        let loginViewModel = LoginViewModel()
        loginViewModel.username = "user1"
        loginViewModel.isLoggedIn = true
        
        return RootView(viewRouter: ViewRouter(), loginViewModel: loginViewModel, homeViewModel: HomeViewModel())
    }
}

