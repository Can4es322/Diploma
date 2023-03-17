import SwiftUI

struct DismissButton: View {
    @Environment(\.presentationMode) var presentation
    var body: some View {
        Button {
            presentation.wrappedValue.dismiss()
        } label: {
             Image(systemName: "arrow.backward")
                .resizable()
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.black)
        }
    }
}
