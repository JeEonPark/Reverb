import Foundation

class NewPostViewModel: ObservableObject {
    private let postRepository = PostRepository()
    
    @Published var title: String = ""
    @Published var location: String = ""
    @Published var description: String = ""
    
    
    func uploadImage(imageData: Data, completion: @escaping (Result<String, Error>) -> Void) {
        postRepository.uploadImage(imageData: imageData, completion: completion)
    }
    
    func createPost(post: Post, completion: @escaping (Result<Post, Error>) -> Void) {
        postRepository.createPost(post: post, completion: completion)
    }
}
