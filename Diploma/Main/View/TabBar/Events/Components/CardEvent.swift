import SwiftUI

struct CardEvent: View {
    let infoCard: ResponseEvent
    @Environment(\.mainWindowSize) var mainWindowSize
    @EnvironmentObject var viewModel: MainViewModel
    
    var body: some View {
        NavigationLink(destination: EventPostView(infoCard: infoCard)
            .environmentObject(viewModel)
            .edgesIgnoringSafeArea(.top)) {
            ZStack(alignment: .bottomLeading) {
                CustomImageDate(imageData: infoCard.avatar)
                    .frame(maxWidth: 400, maxHeight: 200)
                
                Color.black
                    .opacity(0.4)
                
                WalkPerson(countCurrent: infoCard.countPeople, countMaxCount: infoCard.countPeopleMax, color: Color("White"))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                    .padding([.top, .trailing])
                
                VStack(alignment: .leading, spacing: 7) {
                    Text(infoCard.title)
                        .frame(maxWidth: 250, alignment: .leading)
                        .multilineTextAlignment(.leading)
                        .font(.system(size: 18, weight: .medium))
                        .lineSpacing(5)
                        .foregroundColor(Color("White"))
                    
                    HStack(spacing: 7) {
                        Image("Place")
                        Text(infoCard.place ?? "")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(Color("White"))
                    }
                    
                    Text(infoCard.date ?? "")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(Color("White"))
                    
                    HStack(spacing: 8) {
                        ForEach(infoCard.tags) { value in
                            TagCard(text: value.ruName ?? "")
                        }
                    }
                    .padding(.top, 4)
                }
                .padding(.leading, 11)
                .padding(.bottom)
            }
            
        }
        .frame(height: 200)
        .cornerRadius(15)
    }
}
