import SwiftUI
import Foundation
import KeychainSwift

struct StatisticView: View {
    @Environment(\.mainWindowSize) private var mainWindowSize
    @StateObject var viewModel = StatisticViewModel()
    @Binding var isAuthorization: Bool
    var role: String
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                VStack(alignment: .leading, spacing: 0) {
                    Header()
                    
                    Diagram()
                        .padding(.top, 10)
                    
                    if !viewModel.valueStatistic.isEmpty {
                        InfoDiagram()
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.top)
                    }
                }
                .padding(.horizontal, 20)
                
                if !viewModel.valueStatistic.isEmpty {
                    ZStack {
                        Color("BlackBlue")
                            .cornerRadius(28, corners: [.topLeft, .topRight])
                        
                        VStack(spacing: 0) {
                            IndividualDiagrams()
                                .padding(.horizontal, 30)
                                .padding(.bottom, 30)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
            }
            .frame(maxHeight: .infinity)
            .padding(.top, mainWindowSize.height / 21)
        }
        .onAppear() {
            Task {
                try await viewModel.getStatistic()
            }
        }
        .navigationBarHidden(true)
    }
}

extension StatisticView {
    @ViewBuilder
    func Header() -> some View {
        HStack {
            Text("Статистика")
                .customFontBold()
            
            Spacer()
            
            HStack(spacing: 16) {
                NavigationLink(destination: CalendarView().environmentObject(viewModel)) {
                    Image(systemName: "calendar.badge.plus")
                        .foregroundColor(.black)
                }
                
                Button {
                    KeychainSwift().delete("token")
                    isAuthorization = false
                    UserDefaults.standard.set(isAuthorization, forKey: "auth")
                    UserDefaults.standard.removeObject(forKey: "role")
                } label: {
                    Image(systemName: "ipad.and.arrow.forward")
                        .foregroundColor(.black)
                }
            }
            .padding(.horizontal, 4)
            .padding(.vertical, 2)
            .background(Color("Gray4"))
            .cornerRadius(6)
        }
    }
    
    @ViewBuilder
    func Diagram() -> some View {
        if viewModel.selectedDate.rangeDate.startDate == nil && viewModel.selectedDate.rangeDate.endDate == nil {
            Text("За \(viewModel.getMounthForText(date: viewModel.currentDate))")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.black)
        } else {
            HStack(spacing: 2) {
                Group {
                    Text(viewModel.selectedDate.rangeString.startDate ?? "")
                    
                    Text("\(viewModel.selectedDate.rangeInt.startDate) - ")
                    
                    Text(viewModel.selectedDate.rangeString.endDate ?? "")
                    
                    Text("\(viewModel.selectedDate.rangeInt.endDate)")
                }
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.black)
            }
        }
        
        Text("Посещаемость")
            .font(.system(size: 16, weight: .bold))
            .foregroundColor(.black)
            .padding(.top, 14)
        
        if !viewModel.valueStatistic.isEmpty {
            VStack {
                GeometryReader { g in
                    ForEach(0..<viewModel.valueStatistic.count, id: \.self) { i in
                        DrawShape(center: CGPoint(x: (g.size.width / 2), y: (g.size.height / 2 )),
                                  index: i,
                                  data: viewModel.valueStatistic
                        )
                    }
                }
                .frame(height: 330)
            }
        } else {
            Text("По заданным датам не было посещений!")
                .frame(maxWidth: .infinity, alignment: .center)
                .multilineTextAlignment(.center)
                .padding(.top, mainWindowSize.height / 3)
                .customFontBoldMid()
        }
    }
    
    @ViewBuilder
    func InfoDiagram() -> some View {
        Button {
            withAnimation(.easeInOut) {
                viewModel.isInfoTap.toggle()
            }
        } label: {
            Image(systemName: "questionmark.circle.fill")
                .font(.system(size: 26, weight: .bold))
                .foregroundColor(Color("Blue"))
        }
        
        if viewModel.isInfoTap {
            ForEach(0..<Int((Double(viewModel.valueStatistic.count) / 4.0).rounded(.up)), id: \.self) { col in
                HStack(alignment: .center, spacing: 30) {
                    ForEach(0..<4, id: \.self) { row in
                        if (col * 4 + row) < viewModel.valueStatistic.count  {
                            InfoTag(color: viewModel.valueStatistic[col * 4 + row].color, text: viewModel.valueStatistic[col * 4 + row].name)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
    
    @ViewBuilder
    func IndividualDiagrams() -> some View {
        VStack(spacing: 16) {
            ForEach(0..<viewModel.valueStatistic.count, id: \.self) { i in
                
                MiniDiagram(index: i, color: viewModel.valueStatistic[i].color, data: viewModel.valueStatistic, text: viewModel.valueStatistic[i].name, countPerson: viewModel.valueStatistic[i].countPeople)
                
                if i < viewModel.valueStatistic.count - 1 {
                    Divider()
                        .frame(height: 1)
                        .background(Color("Gray5"))
                }
            }
        }
        .padding(.top, 20)
    }
}
