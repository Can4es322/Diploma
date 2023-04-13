import SwiftUI
import Combine

struct CalendarView: View {
    @EnvironmentObject var viewModel: StatisticViewModel
    @Environment(\.presentationMode) var presentation
    @Environment(\.mainWindowSize) private var mainWindowSize
    let days: [String] = ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"]
    @State var isTap = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 14) {
            
            Header()
            
            DayOfTheWeek()
                .padding(.top)
            
            Calendar()
                .padding([.vertical, .top], 10)
            
            CustomBackgroundButton(text: "Выбрать") {
                presentation.wrappedValue.dismiss()
            }
            .padding(.top, 20)
            .opacity(viewModel.selectedDate.rangeDate.startDate != nil && viewModel.selectedDate.rangeDate.endDate != nil ? 1 : 0.5)
            .disabled(!(viewModel.selectedDate.rangeDate.startDate != nil && viewModel.selectedDate.rangeDate.endDate != nil))
            
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
        .onDisappear() {
//            viewModel.clearData()
        }
    }
    
    @ViewBuilder
    func Header() -> some View {
        Text(viewModel.extraDate())
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.system(size: 12, weight: .regular))
            .foregroundColor(.black)
        
        HStack {
            Text(viewModel.getMounthForText(date: viewModel.currentDate))
                .customFontBold()
            
            Spacer()
        
            HStack(spacing: 2) {
                if viewModel.selectedDate.rangeInt.startDate != 0 {
                    Text(viewModel.selectedDate.rangeString.startDate ?? "")
                        .customFontMedium()
                    
                    Text("\(viewModel.selectedDate.rangeInt.startDate) - ")
                        .customFontMedium()
                    
                    if viewModel.selectedDate.rangeInt.endDate != 0  {
                        Text(viewModel.selectedDate.rangeString.endDate ?? "")
                            .customFontMedium()
                        
                         Text("\(viewModel.selectedDate.rangeInt.endDate)")
                            .customFontMedium()
                    }
                }
            }

            
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
                    let index = column * 7 + row
                    
                    if index < viewModel.dates.count {
                        if viewModel.dates[index].day != -1 {
                            Text("\(viewModel.dates[index].day)")
                                .frame(width: 30, height: 30)
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.black)
                                .background(
                                    Circle()
                                        .foregroundColor(viewModel.selectedDate.rangeDate.startDate == viewModel.dates[index].date ||
                                                         viewModel.selectedDate.rangeDate.endDate == viewModel.dates[index].date
                                                         ? Color("Blue") : .clear)
                                )
                                .onTapGesture {
                                    viewModel.tapDate(index: index)
                                }
                        } else {
                            Rectangle()
                                .frame(width: mainWindowSize.width / 13, height: mainWindowSize.width / 13)
                                .foregroundColor(.white)
                        }
                    } else {
                        Rectangle()
                            .frame(width: mainWindowSize.width / 13, height: mainWindowSize.width / 13)
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
