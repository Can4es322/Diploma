import SwiftUI

struct InfoTag: View {
    let color: Color
    let text: String
    
    var body: some View {
        HStack(spacing: 10) {
            Rectangle()
                .frame(width: 20, height: 20)
                .foregroundColor(color)
                .cornerRadius(5)
            
            Text(text)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.black)
        }
    }
}
