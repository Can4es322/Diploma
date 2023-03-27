import SwiftUI

struct CardEvent: View {
    let infoCard: CardEventInfo
    @Environment(\.mainWindowSize) var mainWindowSize
    
    var body: some View {
        NavigationLink(destination: EventPostView(infoCard: infoCard)) {
            ZStack(alignment: .bottomLeading) {
                CustomAsyncImage(url: infoCard.avatar)
                
                Color.black
                    .opacity(0.4)
                
                WalkPerson(countCurrent: infoCard.countCurrentUser, countMaxCount: infoCard.countMaxUser, color: Color("White"))
                    .offset(x: mainWindowSize.width - 115, y: -180)
                
                VStack(alignment: .leading, spacing: 7) {
                    Text(infoCard.title)
                        .frame(maxWidth: 250, alignment: .leading)
                        .font(.system(size: 18, weight: .medium))
                        .lineSpacing(5)
                        .foregroundColor(Color("White"))
                    
                    HStack(spacing: 7) {
                        Image("Place")
                        Text(infoCard.place)
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(Color("White"))
                    }

                    Text(infoCard.date)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(Color("White"))
                    
                    HStack(spacing: 8) {
                        ForEach(infoCard.tags, id: \.self) { value in
                            TagCard(text: value)
                        }
                    }
                    .padding(.top, 4)
                }
                .padding(.leading, 11)
                .padding(.bottom)
                .frame(height: 180)
            }
            .cornerRadius(15)
        }
    }
}
