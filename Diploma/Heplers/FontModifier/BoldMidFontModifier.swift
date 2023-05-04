import SwiftUI

struct BoldMidFontModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 20, weight: .bold))
            .fixedSize(horizontal: false, vertical: true)
            .foregroundColor(.black)
    }
}

extension View {
    func customFontBoldMid() -> some View {
        modifier(BoldMidFontModifier())
    }
}
