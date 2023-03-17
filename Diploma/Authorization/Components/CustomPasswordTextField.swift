import SwiftUI

struct CustomPasswordTextField: View {
    let placeholder: String
    @Binding var text: String
    @State var isActivePassword = false
    
    var body: some View {
        HStack {
            if isActivePassword {
                TextField(placeholder, text: $text)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.black)
            } else {
                SecureField(placeholder, text: $text)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.black)
            }
            Button {
                isActivePassword.toggle()
            } label: {
                Image(systemName: isActivePassword ? "eye" : "eye.slash")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(Color("Gray"))
                    .frame(width: 24, height: 16)
            }
        }
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
