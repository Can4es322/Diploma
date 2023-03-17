import SwiftUI

struct TagEvent: View {
    let text: String
    let index: Int
    @State var active = false
    @Binding var activeTags: [Int]
    let colorsTags: [Color] = [Color("Blue2"), Color("Purple"), Color("Blue3"), Color("Green"), Color("Yellow"), Color("Brown"), Color("Red2")]
    
    var body: some View {
        Button {
            active.toggle()
            if active {
                activeTags.append(index)
            } else {
                activeTags = activeTags.filter {
                    $0 != index
                }
            }
            print(activeTags)
        } label: {
            if active {
                Text(text)
                    .padding()
                    .frame(height: 30)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(Color("White"))
                    .background(colorsTags[index])
                    .cornerRadius(4)
            } else {
                Text(text)
                    .padding()
                    .frame(height: 30)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(Color("White"))
                    .background(Color("Gray1"))
                    .cornerRadius(4)
            }

        }
    }
}
