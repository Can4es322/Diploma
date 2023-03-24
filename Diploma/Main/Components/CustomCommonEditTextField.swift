import SwiftUI
import Combine

struct CustomCommonEditTextField: View {
    let placeholder: String
    @Binding var text: String
    @Binding var isChangeColor: Bool
    @State var currentValue = ""
    
    var body: some View {
        TextField(placeholder, text: $text)
            .padding(.trailing, 11)
            .padding(.leading, 19)
            .foregroundColor(isChangeColor ? Color("Orange") : .black)
            .frame(maxWidth: .infinity)
            .frame(height: 46)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isChangeColor ? Color("Orange") : Color("Gray"), lineWidth: 2)
            )
            .onAppear() {
                currentValue = text
            }
            .onReceive(Just(text), perform: { newValue in
                if isChangeColor != (newValue != currentValue) {
                    isChangeColor = newValue != currentValue
                }
            })
    }
}
