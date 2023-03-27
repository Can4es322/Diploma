import SwiftUI

struct WalkPerson: View {
    let countCurrent: Int
    let countMaxCount: Int
    let color: Color
    
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: "figure.walk")
                .renderingMode(.template)
                .foregroundColor(color)
            
            Text("\(countCurrent)/\(countMaxCount)")
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(color)
        }
    }
}

