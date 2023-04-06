import SwiftUI

struct DayCalendar: View {
    let text: String
    @State var isTap = false
    
    var body: some View {
        Text(text)
            .frame(width: 30, height: 30)
            .font(.system(size: 14, weight: .medium))
            .foregroundColor(.black)
            .background(
                Circle()
                    .foregroundColor(isTap ? Color("Blue") : .clear)
            )
            .onTapGesture {
                isTap.toggle()
            }
    }
}
