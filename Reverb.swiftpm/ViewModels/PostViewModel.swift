import Foundation

class PostViewModel: ObservableObject {
    private let postRepository = PostRepository()
    @Published var post: Post
    @Published var title: String = ""
    
    init(post: Post) {
        self.post = post
        self.title = title
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
