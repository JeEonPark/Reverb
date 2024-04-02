import Foundation

class Constants {
    static let serverIP = "http://114.206.86.76:32622"
//    static let serverIP = "http://192.168.35.187:32622"
}

class URLBuilder {
    static func buildURL(path: String) -> URL? {
        guard let baseURL = URL(string: Constants.serverIP) else {
            print("Invalid base URL")
            return nil
        }
        return baseURL.appendingPathComponent(path)
    }
}
