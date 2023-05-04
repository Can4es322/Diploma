import SwiftUI

struct CustomDropDown: View {
    let content: Array<String>
    @Binding var isIndex: Int
    @State var isTapped = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 0) {
                Text(content[isIndex])
                    .fixedSize(horizontal: true, vertical: true)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.black)
                Spacer()
                Image(systemName: isTapped ? "chevron.up" : "chevron.down")
                    .resizable()
                    .frame(width: 16, height: 7)
            }
            .onTapGesture {
                withAnimation(Animation.easeInOut(duration: 0.5)) {
                    isTapped.toggle()
                }
            }
            
            if isTapped {
                ScrollView(.vertical) {
                    VStack(alignment: .leading) {
                        ForEach(Array(zip(content.indices, content)), id: \.0) { index, element in
                            Button {
                                isIndex = index
                            } label: {
                                if isIndex == index {
                                    Text(element)
                                        .frame(height: 20)
                                        .font(.system(size: 14, weight: .bold))
                                        .foregroundColor(.black)
                                } else {
                                    Text(element)
                                        .frame(height: 20)
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundColor(.black)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
            }
        }
        .padding()
       
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .strokeBorder(Color("Gray"), lineWidth: 2)
        )
        .frame(maxHeight: 180, alignment: .top)
    }
}
