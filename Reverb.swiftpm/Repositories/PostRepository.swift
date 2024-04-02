import Foundation

class PostRepository {
    func fetchRecentPosts(completion: @escaping (Result<[Post], Error>) -> Void) {
        guard let requestURL = URLBuilder.buildURL(path: "/posts") else {
            completion(.failure(NSError(domain: "Error building request URL", code: 0, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
                return
            }
            
            do {
                // Parse JSON data into array of Post objects
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let posts = try decoder.decode([Post].self, from: data)
                
                completion(.success(posts))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchImage(for post: Post, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let imageURL = URLBuilder.buildURL(path: "/photo/\(post.id)") else {
            completion(.failure(NSError(domain: "Error building image URL", code: 0, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: imageURL) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No image data received", code: 0, userInfo: nil)))
                return
            }
            
            completion(.success(data))
        }.resume()
    }

    
    func uploadImage(imageData: Data, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URLBuilder.buildURL(path: "/upload-image") else {
            completion(.failure(NSError(domain: "Error creating URL", code: 0, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // multipart/form-data 경계 생성
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        // HTTP 바디 구성
        var body = Data()
        
        // 이미지 데이터 추가
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"image\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
        request.httpBody = body
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data, let imageUrlString = String(data: data, encoding: .utf8) else {
                completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
                return
            }
            
            completion(.success(imageUrlString))
        }.resume()
    }
    
    func createPost(post: Post, completion: @escaping (Result<Post, Error>) -> Void) {
        guard let url = URLBuilder.buildURL(path: "/create-post") else {
            completion(.failure(NSError(domain: "Error building request URL", code: 0, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        do {
            request.httpBody = try encoder.encode(post)
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let createdPost = try decoder.decode(Post.self, from: data)
                completion(.success(createdPost))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
