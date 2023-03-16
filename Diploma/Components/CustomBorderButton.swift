import SwiftUI

struct CustomBorderButton: View {
    let text: String
    let action: () -> ()
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(text)
                .frame(maxWidth: .infinity, alignment: .center)
                .frame(height: 48)
                .font(.system(size: 15, weight: .medium))
                .background(Color.white)
                .foregroundColor(Color("Blue"))
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color("Blue"), lineWidth: 2)
                )
        }
    }
}
