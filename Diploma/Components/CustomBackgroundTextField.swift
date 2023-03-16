
import SwiftUI

struct CustomBackgroundTextField: View {
    let placeholder: String
    @Binding var text: String
    @Binding var isError: Bool?
    
    var body: some View {
        HStack {
            TextField(placeholder, text: $text)
                .font(.system(size: 14, weight: .medium))
            
            if isError == true {
                Image("Checkmark.bubble")
            }
            
            if isError == false {
                Image(systemName: "multiply")
                    .renderingMode(.template)
                    .foregroundColor(Color("Red"))
                    .font(.system(size: 20, weight: .bold))
            }
        }
        .padding(.horizontal, 19)
        .frame(maxWidth: .infinity)
        .frame(height: 46)
        .background(Color("Gold"))
        .cornerRadius(12)
    }
}
