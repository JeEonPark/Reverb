import Foundation

class HomeViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var posts: [Post] = []
    private let postRepository = PostRepository()
    
    func fetchRecentPosts() {
        isLoading = true
        postRepository.fetchRecentPosts { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let fetchedPosts):
                    self.posts = fetchedPosts
                case .failure(let error):
                    print("Error fetching recent posts: \(error)")
                }
            }
        }
    }
    
    func fetchImage(for post: Post, completion: @escaping (Data?) -> Void) {
        postRepository.fetchImage(for: post) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let imageData):
                    completion(imageData)
                case .failure(let error):
                    print("Error fetching image: \(error)")
                    completion(nil)
                }
            }
        }
    }
}
