import SwiftUI

public struct FontManager {
    /// https://stackoverflow.com/questions/71916171/how-to-change-font-in-xcode-swift-playgrounds-swiftpm-project
    public static func registerFonts() {
        registerFont(bundle: Bundle.main, fontName: "Shalimar-Regular", fontExtension: ".ttf")
        registerFont(bundle: Bundle.main, fontName: "Pretendard-Black", fontExtension: ".otf")
        registerFont(bundle: Bundle.main, fontName: "Pretendard-Bold", fontExtension: ".otf")
        registerFont(bundle: Bundle.main, fontName: "Pretendard-ExtraBold", fontExtension: ".otf")
        registerFont(bundle: Bundle.main, fontName: "Pretendard-ExtraLight", fontExtension: ".otf")
        registerFont(bundle: Bundle.main, fontName: "Pretendard-Light", fontExtension: ".otf")
        registerFont(bundle: Bundle.main, fontName: "Pretendard-Medium", fontExtension: ".otf")
        registerFont(bundle: Bundle.main, fontName: "Pretendard-Regular", fontExtension: ".otf")
        registerFont(bundle: Bundle.main, fontName: "Pretendard-SemiBold", fontExtension: ".otf")
        registerFont(bundle: Bundle.main, fontName: "Pretendard-Thin", fontExtension: ".otf")

        //change according to your ext.
    }
    
    fileprivate static func registerFont(bundle: Bundle, fontName: String, fontExtension: String) {
        print(Bundle.main)
        guard let fontURL = bundle.url(forResource: fontName, withExtension: fontExtension),
              let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
              let font = CGFont(fontDataProvider) else {
            fatalError("Couldn't create font from data")
        }
        
        var error: Unmanaged<CFError>?
        
        CTFontManagerRegisterGraphicsFont(font, &error)
    }
}
