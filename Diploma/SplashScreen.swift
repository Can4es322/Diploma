import SwiftUI

struct SplashScreen: View {
    @State var nextView = false
    @State var endCircle: CGFloat = 0
    @State var opacity: Double = 1
    
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
            .onAppear(perform: animationCircle)
            .onAppear() {
                opacity = 0
                endCircle = 1
            }
            .animation(.linear(duration: 1.3))
        }
    }
    
    func animationCircle() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            nextView = true
        }
    }
}
