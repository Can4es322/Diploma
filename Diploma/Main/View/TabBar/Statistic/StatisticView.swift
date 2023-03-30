import SwiftUI

struct StatisticView: View {
    @Environment(\.mainWindowSize) private var mainWindowSize
    @StateObject var viewModel = StatisticViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Header()
            
            Diagram()
                .padding(.top)
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, mainWindowSize.height / 21)
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
                NavigationLink(destination: AddEventView().environmentObject(viewModel)) {
                    Image(systemName: "calendar.badge.plus")
                        .foregroundColor(.black)
                }
                
                Button {
                    
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
        Text("За \(viewModel.getCurrentMounth())")
            .font(.system(size: 16, weight: .medium))
            .foregroundColor(.black)
        
        Text("Посещаемость")
            .font(.system(size: 16, weight: .bold))
            .foregroundColor(.black)
            .padding(.top, 16)
        
        
    }
}
