import SwiftUI

struct TagCard: View {
    let text: String
    
    var body: some View {
        Text(text)
            .fixedSize(horizontal: false, vertical: true)
            .lineLimit(2)
            .padding(6)
            .frame(height: 26)
            .font(.system(size: 12, weight: .regular))
            .foregroundColor(Color("White"))
            .background(Color("Gray2"))
            .cornerRadius(4)
    }
}
