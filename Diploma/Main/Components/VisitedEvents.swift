import SwiftUI

struct VisitedEvents: View {
    let eventsInfo: ResponseEvent
    
    var body: some View {
        HStack(alignment: .center, spacing: 11) {
            Image(uiImage: UIImage(data: eventsInfo.avatar)!)
//            CustomAsyncImage(url: eventsInfo.photos[0])
                .frame(width: 98, height: 98)
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(eventsInfo.title)
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.black)
                
                Text(eventsInfo.date ?? "")
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(Color("Gray5"))
                
                HStack(spacing: 7) {
                    Image("Place")
                        .renderingMode(.template)
                        .foregroundColor(Color("Gray5"))
                                         
                    Text(eventsInfo.place ?? "")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(Color("Gray5"))
                }
                
                HStack(spacing: 7) {
                    Image(systemName: "figure.walk")
                        .renderingMode(.template)
                        .foregroundColor(Color("Gray5"))
                    
                    Text("\(eventsInfo.countPeople)/\(eventsInfo.countPeopleMax)")
                        .fixedSize(horizontal: false, vertical: true)
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(Color("Gray5"))
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
