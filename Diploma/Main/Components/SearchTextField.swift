import SwiftUI

struct SeacrhTextField: View {
    @Binding var inputText: String
    let placeholderText: String
    
    var body: some View {
        HStack {
            TextField(placeholderText, text: $inputText)
            
            Image(systemName: "magnifyingglass")
                .resizable()
                .renderingMode(.template)
                .frame(width: 20, height: 20)
                .foregroundColor(Color("Gray"))
        }
        
        .padding(.vertical, 9)
        .padding(.leading, 13)
        .padding(.trailing, 15)
        .overlay(
            RoundedRectangle(cornerRadius: 6)
                .strokeBorder(Color("Gray"), lineWidth: 2)
        )
        .frame(maxWidth: .infinity)
        .frame(height: 40)
        .background(Color.white)
        .padding(.top, 20)
    }
}
