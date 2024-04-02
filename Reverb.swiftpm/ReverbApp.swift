import SwiftUI

@main
struct ReverbApp: App {
    
    init() {
        FontManager.registerFonts()
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                Color.black.ignoresSafeArea()
                ContentView()
            }
            
        }
    }
}
