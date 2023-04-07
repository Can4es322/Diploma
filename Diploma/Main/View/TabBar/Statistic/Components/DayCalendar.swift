import SwiftUI

struct DayCalendar: View {
    @Binding var dates: [DateValue]
    let index: Int
    
    var body: some View {
        Text("\(dates[index].day)")
            .frame(width: 30, height: 30)
            .font(.system(size: 14, weight: .medium))
            .foregroundColor(.black)
            .background(
                Circle()
                    .foregroundColor(dates[index].range == .start || dates[index].range == .end ? Color("Blue") : .clear)
            )
            .onTapGesture {
                let start = dates.filter { $0.range == .start }
                let end = dates.filter { $0.range == .end }
            
                if dates[index].range == .start || dates[index].range == .end {
                    dates[index].range = .none
                } else if start.count < 1 {
                    dates[index].range = .start
                } else if start.count == 1 && end.isEmpty && dates[index].day > start[0].day{
                    dates[index].range = .end
                }
            }
    }
}
