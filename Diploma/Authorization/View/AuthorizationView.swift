import SwiftUI

struct AuthorizationView: View {
    @Environment(\.mainWindowSize) var mainWindowSize
    @State var isRegistrationView = false
    @State var isLoginView = false

    var body: some View {
        NavigationView {
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
                
                NavigationLink(destination: RegistrationView(), isActive: $isRegistrationView) {
                    CustomBackgroundButton(text: "Регистрация") {
                        isRegistrationView.toggle()
                    }
                }

                NavigationLink(destination: LoginView(), isActive: $isLoginView) {
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
}
