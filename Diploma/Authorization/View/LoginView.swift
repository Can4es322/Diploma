import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @Environment(\.mainWindowSize) private var mainWindowSize
    @Environment(\.presentationMode) private var presentation
    @Binding var isAuthUser: Bool
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center, spacing: 0) {
                Image("AuthImage")
                    .padding(.top, mainWindowSize.height / 18)
                
                Text("Привет,\nС Возращением!")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, mainWindowSize.height / 22)
                    .customFontBold()
                
                CustomBackgroundTextField(placeholder: "Почта", text: $viewModel.loginText, isError: $viewModel.isErrorLogin)
                    .padding(.top, 20)
                
                CustomPasswordTextField(placeholder: "Пароль", text: $viewModel.passwordText)
                    .padding(.top, 28)
                
                Text("Забыли Пароль?")
                    .underline()
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.top, 18)
                    .customFontMedium()
                
                CustomBackgroundButton(text: "Войти") {
                    Task {
                        await viewModel.registerUser()
                        isAuthUser = viewModel.isErrorLogin ?? false
                    }
                }
                .fixedSize(horizontal: false, vertical: true)
                .padding(.top, mainWindowSize.height / 15)
                .opacity(viewModel.checkIsEmptyTextFields() ? 0.5 : 1)
                .disabled(viewModel.checkIsEmptyTextFields())
                
                FooterContent()
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

extension LoginView {
    @ViewBuilder
    func FooterContent() -> some View {
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
    }
}
