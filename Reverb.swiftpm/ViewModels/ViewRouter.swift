import Foundation

class ViewRouter: ObservableObject {
    @Published var currentView: Views = Views.Login
    
    func goTo(_ view: Views) {
        currentView = view
    }
    
    enum Views {
        case Login
        case Root
        case NewPost
    }
}
