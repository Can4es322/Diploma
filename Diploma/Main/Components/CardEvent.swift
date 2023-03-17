import SwiftUI

struct CardEvent: View {
    let infoCard: CardEventInfo
    @Environment(\.mainWindowSize) var mainWindowSize
    
    var body: some View {
        ZStack(alignment: .center) {
            Image(infoCard.photos[0])
            
            VStack(alignment: .center, spacing: 4) {
                Text(infoCard.title)
                    .frame(width: mainWindowSize.width / 1.5)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.white)
                
                HStack(spacing: 7) {
                    Image("Place")
                    Text(infoCard.place)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.white)
                }
                
                Text(infoCard.date)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.white)
                
                ForEach(infoCard.tags, id: \.self) { str in
                    HStack {
                        
                    }
                }
            }
        }
    }
}
