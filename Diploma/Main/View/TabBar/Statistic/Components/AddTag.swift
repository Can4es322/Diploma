import SwiftUI

struct AddTag: View {
    let text: String
    @Binding var isTap: Bool
    @Binding var tags: [String]
    
    var body: some View {
        Button {
            withAnimation {
                isTap.toggle()
            }
            if isTap {
                tags.append(text)
            } else {
                tags = tags.filter {
                    $0 != text
                }
            }
            print(tags)
            
        } label: {
            HStack {
                Text(text)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.black)
                
                Spacer()
                
                Circle()
                    .frame(width: 15, height: 15)
                    .foregroundColor(isTap ? Color("Green"): .white)
            }
            .frame(height: 50)
            .padding(.horizontal, 17)
            .background(Color("Gray1"))
            .cornerRadius(15)
        }
        .disabled(!isTap && tags.count >= 3)
        .opacity(!isTap && tags.count >= 3 ? 0.5 : 1)
    }
}
