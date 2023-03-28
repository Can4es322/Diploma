import SwiftUI

struct SplashScreen: View {
    @State private var nextView = false
    @State private var endCircle: CGFloat = 0
    @State private var opacity: Double = 1
    
    var body: some View {
        if nextView {
            StartView()
        } else {
            ZStack {
                Color.white
                
                Image("ufuCircle")
                    .resizable()
                    .scaledToFit()
                
                Circle()
                    .trim(from: 0, to: endCircle)
                    .rotation(Angle(degrees: 90))
                    .stroke(lineWidth: 100)
                    .foregroundColor(.white)
                    .padding(.top)
                
                Image("ufuCenter")
                    .resizable()
                    .scaledToFit()
            }
            .opacity(opacity)
            .onAppear {
                Task {
                    try await Task.sleep(nanoseconds: 15_000_000_00)
                    nextView = true
                }
            }
            .onAppear {
                opacity = 0
                endCircle = 1
            }
            .animation(.linear(duration: 1.3))
        }
    }
}
