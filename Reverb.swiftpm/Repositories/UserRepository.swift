import Foundation

class UserRepository {
    func authenticate(username: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        let user = User(username: username, password: password)
        
        guard let requestData = try? JSONEncoder().encode(user) else {
            completion(.failure(NSError(domain: "Error encoding user data", code: 0, userInfo: nil)))
            return
        }
        
        guard let requestURL = URLBuilder.buildURL(path: "/login") else {
            completion(.failure(NSError(domain: "Error building request URL", code: 0, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = requestData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "Unknown error", code: 0, userInfo: nil)))
                return
            }
            
            if httpResponse.statusCode == 200 {
                completion(.success(true))
            } else {
                completion(.success(false))
            }
        }.resume()
    }
}
