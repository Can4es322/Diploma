import SwiftUI

struct VisitedEvents: View {
    let eventsInfo: CardEventInfo
    
    var body: some View {
        HStack(spacing: 10) {
            CustomAsyncImage(url: eventsInfo.photos[0])
                .frame(width: 98, height: 92)
                .cornerRadius(10)
            
            VStack(spacing: 4) {
                    
            }
        }
    }
}
