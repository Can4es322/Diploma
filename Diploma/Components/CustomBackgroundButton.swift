import SwiftUI

struct CustomBackgroundButton: View {
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
                .foregroundColor(.white)
                .background(Color("Blue"))
        }
        .cornerRadius(30)
    }
}
