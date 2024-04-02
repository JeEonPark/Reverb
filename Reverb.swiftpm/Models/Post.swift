import Foundation

struct Post: Codable {
    let id: Int
    let uploader: String
    let title: String
    let location: String
    let description: String
    let upload_datetime: String
    let duration: String
    let comments: [Comment]
    let likes: Int
}

struct Comment: Codable, Hashable {
    let user: String
    let comment: String
}
