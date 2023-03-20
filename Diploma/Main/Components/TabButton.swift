import SwiftUI

struct TabButton: View {
    let image: String
    let title: String
    @Binding var selectedTab: String
    @Environment(\.mainWindowSize) var mainWindowSize

    
    var body: some View {
        Button {
            withAnimation(Animation.easeOut(duration: 0.2)) {
                selectedTab = title
            }
        } label: {
            VStack(spacing: 6) {
                    RoundedRectangle(cornerRadius: 1)
                        .fill(Color("Blue4").opacity(selectedTab == title ? 1 : 0))
                        .frame(width: 40, height: 5)
                        .padding(.bottom, 6)

                    
                    Image(systemName: image)
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(selectedTab == title ? Color("Blue4") : Color("Gray3"))
                    
                    Text(title)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(selectedTab == title ? Color("Blue4") : Color("Gray3"))
                
            }
        }
    }
}
