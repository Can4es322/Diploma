import SwiftUI

struct DrawShape: View {
    @State var trimValueTo: CGFloat = 0
    @State var trimValueFrom: CGFloat = 0
    @State var trimLineTo: CGFloat = 0
    @State var trimLineFrom: CGFloat = 0
    let center: CGPoint
    let index: Int
    let data: [ValueDiagram]
    let diametr: Double = 180
    let radius: Double
    
    init(center: CGPoint, index: Int, data: [ValueDiagram]) {
        self.center = center
        self.index = index
        self.data = data
        self.radius = diametr / 2
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            Path { path in
                path.addEllipse(in: CGRect(origin: CGPoint(x: center.x - radius, y: center.y - radius), size: CGSize(width: diametr, height: diametr)))
            }
            .trim(from: trimValueFrom, to: trimValueTo)
            .stroke(lineWidth: 60)
            .foregroundColor(data[index].color)
            
            Path { path in
                path.move(to: center)
                path.addLine(to: centerArc())
            }
            .trim(from: trimLineTo, to: trimLineFrom)
            .stroke(.black, lineWidth: 1)

            
            Text("\(String(format: "%.0f", data[index].value * 100))%")
                .font(.system(size: 14, weight: .bold))
                .padding(1)
                .background(Color.white)
                .position(centerArc())
        }
        .onAppear() {
            from()
            to()
            trimLineTo = 0.6
            trimLineFrom = 0.9
        }
        .animation(.easeInOut(duration: 2), value: trimValueTo)
        .animation(.easeInOut(duration: 2), value: trimValueFrom)
        .animation(.easeInOut(duration: 2), value: trimLineTo)
        .animation(.easeInOut(duration: 2), value: trimLineFrom)
    }
    
    func convertPercentToGradus() -> Double {
        var temp: Double = 0
        
        for i in 0...index {
            temp += index == i ? data[i].value / 2 : data[i].value
        }
        return 3.6 * temp * 100
    }
    
    func centerArc() -> CGPoint {
        let linePointYConst: Double = 2
        
        return CGPoint(x: center.x + radius * sin(Angle(degrees: -convertPercentToGradus() + 90).radians) * linePointYConst,
                        y: center.y + radius * cos(Angle(degrees: -convertPercentToGradus() + 90).radians) * linePointYConst)
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
