import SwiftUI

struct MediumFontModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.black)
            .font(.system(size: 11, weight: .medium))
            .fixedSize(horizontal: false, vertical: true)
    }
}

extension View {
    func customFontMedium() -> some View {
        modifier(MediumFontModifier())
    }
}
