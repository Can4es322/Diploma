import SwiftUI
import Combine

struct CalendarView: View {
    @EnvironmentObject var viewModel: StatisticViewModel
    @Environment(\.mainWindowSize) private var mainWindowSize
    let days: [String] = ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"]
    
    var body: some View {
        VStack(alignment: .center, spacing: 14) {
            
            Header()
            
            DayOfTheWeek()
                .padding(.top)
            
            Calendar()
                .padding([.vertical, .top], 10)
            
            Spacer()
        }
        .onAppear {
            viewModel.dates = viewModel.extractDate()
        }
        .padding(.horizontal, 20)
        .padding(.top, mainWindowSize.height / 21)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("Календарь", displayMode: .inline)
        .navigationBarItems(
            leading: DismissButton()
        )
    }
    
    @ViewBuilder
    func Header() -> some View {
        Text(viewModel.extraDate())
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.system(size: 12, weight: .regular))
            .foregroundColor(.black)
        
        HStack {
            Text(viewModel.getMounthForText())
                .customFontBold()
            
            Spacer()
            
            HStack(spacing: 14) {
                Button {
                    withAnimation {
                        viewModel.minusMounth()
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20, weight: .medium))
                }
                
                Button {
                    withAnimation {
                        viewModel.plusMounth()
                    }
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 20, weight: .medium))
                }
            }
        }
    }
    
    @ViewBuilder
    func DayOfTheWeek() -> some View {
        HStack(spacing: 0) {
            ForEach(days, id: \.self) { day in
                Text(day)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.black)
                
                if day != "Вс"{
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
    }
    
    @ViewBuilder
    func Calendar() -> some View {
        ForEach(0..<5) { column in
            HStack {
                ForEach(0..<7) { row in
                    if column * 7 + row < viewModel.dates.count {
                        if viewModel.dates[column * 7 + row].day != -1 {
                            DayCalendar(text: String(viewModel.dates[column * 7 + row].day))
                            
                        } else {
                            Rectangle()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.white)
                        }
                    } else {
                        Rectangle()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.white)
                    }
                    if row != 6 {
                        Spacer()
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
