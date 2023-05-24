import SwiftUI

struct MiniDiagram: View {
    @State var trimValueTo: CGFloat = 0
    @State var trimValueFrom: CGFloat = 0
    let index: Int
    let color: Color
    let data: [ValueDiagram]
    let text: String
    let countPerson: Int
    let diametr: Double = 70
    
    var body: some View {
        HStack(alignment: .center) {
            ZStack {
                Path { path in
                    path.addEllipse(in: CGRect(origin: .zero, size: CGSize(width: diametr, height: diametr)))
                }
                .stroke(lineWidth: 20)
                .foregroundColor(Color.white)
                
                Path { path in
                    path.addEllipse(in: CGRect(origin: .zero, size: CGSize(width: diametr, height: diametr)))
                }
                .trim(from: trimValueFrom, to: trimValueTo)
                .stroke(lineWidth: 20)
                .foregroundColor(color)
            }
            .padding()
            .frame(maxWidth: 100)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(text)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
                
                Text("\(String(format: "%.0f", data[index].value * 100))%")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
            }
            .padding(.leading, 20)
            
            Spacer()
            
            HStack(alignment: .center, spacing: 6) {
                Image(systemName: "figure.walk")
                    .renderingMode(.template)
                    .foregroundColor(.white)
                
                Text("\(countPerson)")
                    .fixedSize(horizontal: true, vertical: false)
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.white)
            }
        }
        .onAppear {
            from()
            to()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 90)
    }
    
    func from() {
        var temp: Double = 0
        
        if index == 0 {
            trimValueFrom = 0
        } else {
            for i in 0...index-1 {
                temp += Double(data[i].value)
            }
            trimValueFrom = temp
        }
    }
    
    func to() {
        var temp: Double = 0
        
        for i in 0...index {
            temp += Double(data[i].value)
        }
        trimValueTo = temp
    }
}
