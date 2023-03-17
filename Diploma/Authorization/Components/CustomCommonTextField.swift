import SwiftUI

struct CustomCommonTextField: View {
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        TextField(placeholder, text: $text)
            .padding(.trailing, 11)
            .padding(.leading, 19)
            .frame(maxWidth: .infinity)
            .frame(height: 46)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color("Gray"), lineWidth: 2)
            )
    }
}
