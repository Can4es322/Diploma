import SwiftUI

struct AuthorizationView: View {
    @Environment(\.mainWindowSize) private var mainWindowSize
    @State private var isRegistrationView = false
    @State private var isLoginView = false
    @Binding var token: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Image("ICTIB")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxHeight: 250)
                .padding(.top, mainWindowSize.height / 10)
            
            Spacer()
            
            Group {
                Text("ИКТИБ ЮФУ")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.black)
                
                Text("Записывайся на  мероприятия\nи проводи  свое время с пользой")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.black)
                    .padding(.top, 14)
            }
            .multilineTextAlignment(.center)
            
            Spacer()
            
            NavigationLink(destination: RegistrationView(token: $token), isActive: $isRegistrationView) {
                CustomBackgroundButton(text: "Регистрация") {
                    isRegistrationView.toggle()
                }
            }
            
            NavigationLink(destination: LoginView(token: $token) , isActive: $isLoginView) {
                CustomBorderButton(text: "Войти") {
                    isLoginView.toggle()
                }
            }
            .padding(.top, 18)
            .padding(.bottom)
        }
        .padding(.horizontal, 35)
    }
}
