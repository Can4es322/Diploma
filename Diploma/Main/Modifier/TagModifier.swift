
import SwiftUI

struct TagModifier: ViewModifier {
    let colorBackground: Color
    
    func body(content: Content) -> some View {
        content
            .fixedSize(horizontal: true, vertical: false)
            .padding(.vertical, 4)
            .padding(.horizontal, 10)
            .frame(height: 30)
            .font(.system(size: 12, weight: .regular))
            .foregroundColor(Color("White"))
            .background(colorBackground)
            .cornerRadius(4)
    }
}

extension View {
    func customTag(colorBackground: Color) -> some View {
        modifier(TagModifier(colorBackground: colorBackground))
    }
}
