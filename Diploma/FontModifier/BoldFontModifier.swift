import SwiftUI

struct BoldFonModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 24, weight: .bold))
            .foregroundColor(.black)
            .fixedSize(horizontal: false, vertical: true)
    }
}

extension View {
    func customFontBold() -> some View {
        modifier(BoldFonModifier())
    }
}
