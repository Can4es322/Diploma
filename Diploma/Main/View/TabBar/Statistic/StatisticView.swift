import SwiftUI
import Foundation

struct StatisticView: View {
    @Environment(\.mainWindowSize) private var mainWindowSize
    @StateObject var viewModel = StatisticViewModel()
    
    let value: [ValueDiagram] = [
        ValueDiagram(name: "MOP", color: .red, value: 0.35),
        ValueDiagram(name: "BIT", color: .blue, value: 0.15),
        ValueDiagram(name: "VM", color: .green, value: 0.30),
        ValueDiagram(name: "SAPR", color: .orange, value: 0.15),
        ValueDiagram(name: "VT", color: .gray, value: 0.02),
        ValueDiagram(name: "SCP", color: .yellow, value: 0.03),
    ]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 0) {
                    Header()
                    
                    Diagram()
                    
                    InfoDiagram()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.top)
                }
                .padding(.horizontal, 20)
                
                VStack(spacing: 4) {
                    IndividualDiagrams()
                        .padding(.horizontal, 30)
                        .padding(.bottom, 30)
                }
                .padding(.top, 12)
                .frame(maxWidth: .infinity, alignment: .center)
                .background(Color("BlackBlue"))
                .cornerRadius(28)
            }
            .padding(.top, mainWindowSize.height / 21)
        }
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
                NavigationLink(destination: EmptyView()) {
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
            .padding(.top, 14)
        
        VStack {
            GeometryReader { g in
                if #available(iOS 15.0, *) {
                    ForEach(0..<value.count, id: \.self) { i in
                        DrawShape(center: CGPoint(x: (g.size.width / 2), y: (g.size.height / 2 )),
                                  index: i,
                                  data: value
                        )
                    }
                    
                    
                } else {
                    // Fallback on earlier versions
                }
            }
            .frame(height: 330)
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
            ForEach(0..<Int((Double(value.count) / 4.0).rounded(.up)), id: \.self) { col in
                HStack(alignment: .center, spacing: 30) {
                    ForEach(0..<4, id: \.self) { row in
                        if (col * 4 + row) < value.count  {
                            InfoTag(color: value[col * 4 + row].color, text: value[col * 4 + row].name)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
    
    @ViewBuilder
    func IndividualDiagrams() -> some View {
        ForEach(0..<value.count, id: \.self) { i in
            VStack(spacing: 20) {
                MiniDiagram(index: i, color: value[i].color, data: value, text: value[i].name, countPerson: 20)
                
                if i < value.count - 1 {
                    Divider()
                        .frame(height: 1)
                        .background(Color("Gray5"))
                }
            }
        }
    }
}


//                    let value: [ValueDiagram] = [
//                        ValueDiagram(name: "MOP", color: .red, value: 0.09),
//                        ValueDiagram(name: "BIT", color: .blue, value: 0.09),
//                        ValueDiagram(name: "VM", color: .green, value: 0.09),
//                        ValueDiagram(name: "SAPR", color: .orange, value: 0.09),
//                        ValueDiagram(name: "VT", color: .gray, value: 0.09),
//                        ValueDiagram(name: "IMS", color: .yellow, value: 0.09),
//                        ValueDiagram(name: "IASB", color: .indigo, value: 0.09),
//                        ValueDiagram(name: "IBTS", color: .mint, value: 0.09),
//                        ValueDiagram(name: "BIPZ", color: .pink, value: 0.09),
//                        ValueDiagram(name: "SCP", color: .yellow, value: 0.09),
//                        ValueDiagram(name: "SAIT", color: .teal, value: 0.1),
//                    ]
