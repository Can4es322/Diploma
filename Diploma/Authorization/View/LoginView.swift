import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel = LoginViewModel()
    @Environment(\.mainWindowSize) var mainWindowSize
    @Environment(\.presentationMode) var presentation
    @Binding var isAuthUser: Bool
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center, spacing: 0) {
                Image("AuthImage")
                    .padding(.top, mainWindowSize.height / 18)
                
                Text("Привет,\nС Возращением!")
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.top, mainWindowSize.height / 22)
                
                CustomBackgroundTextField(placeholder: "Почта", text: $viewModel.loginText, isError: $viewModel.isErrorLogin)
                    .padding(.top, 20)
                
                CustomPasswordTextField(placeholder: "Пароль", text: $viewModel.passwordText)
                    .padding(.top, 28)
                
                Text("Забыли Пароль?")
                    .underline()
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .foregroundColor(.black)
                    .font(.system(size: 11, weight: .medium))
                    .padding(.top, 18)
                
                CustomBackgroundButton(text: "Войти") {
                    viewModel.registrationUser() {
                        self.isAuthUser = self.viewModel.isErrorLogin ?? false
                    }
                }
                .fixedSize(horizontal: false, vertical: true)
                .padding(.top, mainWindowSize.height / 15)
                .opacity(viewModel.checkIsEmptyTextFields() ? 0.5 : 1)
                .disabled(viewModel.checkIsEmptyTextFields())
                
                HStack(spacing: 1) {
                    Text("Еще не имеете аккаунт? ")
                        .foregroundColor(Color("Gray"))
                    
                    NavigationLink(destination: RegistrationView(isAuthUser: $isAuthUser), label: {
                        Text("Регистрация")
                            .foregroundColor(Color("Blue"))
                            .underline()
                    })
                    
                }
                .font(.system(size: 11, weight: .medium))
                .padding(.bottom)
                .padding(.top, mainWindowSize.height / 14)
                
                Spacer()
            }
            .padding(.horizontal, 30)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: DismissButton())
        }
    }
}
