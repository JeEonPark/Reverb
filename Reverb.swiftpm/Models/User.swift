import Foundation

struct User: Codable { // Codable -> User 데이터를 Json으로 직렬화 및 역직렬화를 할 수 있음
    let username: String
    let password: String
}
