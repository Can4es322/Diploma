import SwiftUI

struct RegistrationView: View {
    @StateObject private var viewModel = RegistrationViewModel()
    @Environment(\.mainWindowSize) private var mainWindowSize
    @Binding var isAuthUser: Bool
    
    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center, spacing: 0) {
                    
                    Text("Создать\nНовый Аккаунт")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .customFontBold()
                        .padding(.top, mainWindowSize.height / 14)
                    
                    TextFieldsContent()
                        .padding(.top, mainWindowSize.height / 18)
                    
                    CustomBackgroundButton(text: "Создать Аккаунт") {
                        viewModel.checkIsCorrectEmail()
                    }
                    .padding(.top, mainWindowSize.height / 14)
                    .opacity(viewModel.checkIsEmptyTextFields() ? 0.5 : 1)
                    .disabled(viewModel.checkIsEmptyTextFields())
                    
                    FooterContent()
                        .font(.system(size: 11, weight: .medium))
                        .padding(.top, mainWindowSize.height / 14)
                    
                    Spacer()
                }
                .padding(.horizontal, 30)
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: DismissButton())
            }
            
            if viewModel.isBottomSheet {
                BottomSheetView(isAuthUser: $isAuthUser)
                    .environmentObject(viewModel)
            }
        }
    }
}

extension RegistrationView {
    @ViewBuilder
    func TextFieldsContent() -> some View {
        VStack(spacing: mainWindowSize.height / 30) {
            CustomBackgroundTextField(placeholder: "Почта", text: $viewModel.loginText, isError: $viewModel.isErrorLogin)
            
            CustomPasswordTextField(placeholder: "Пароль", text: $viewModel.passwordText)
            
            CustomPasswordTextField(placeholder: "Повторите пароль", text: $viewModel.confirmPassword)
            
            HStack(spacing: 11) {
                Button {
                    viewModel.isPolitical.toggle()
                } label: {
                    ZStack {
                        Rectangle()
                            .frame(width: 26, height: 26)
                            .foregroundColor(Color("Gray"))
                            .cornerRadius(6)
                        
                        if viewModel.isPolitical {
                            Image("Checkmark.bubble")
                                .renderingMode(.template)
                                .foregroundColor(.black)
                        }
                    }
                }
                
                Group {
                    Text("Я ознакомлен с ") +
                    Text("Политикой конфиденциальности")
                        .foregroundColor(Color("Blue"))
                        .underline()
                    +
                    Text(" и даю согласие на ") +
                    Text("Обработку моих данных")
                        .foregroundColor(Color("Blue"))
                        .underline()
                }
                .fixedSize(horizontal: false, vertical: true)
                .font(.system(size: 11, weight: .medium))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    @ViewBuilder
    func FooterContent() -> some View {
        HStack(spacing: 1) {
            Text("Уже имеете аккаунт? ")
                .foregroundColor(Color("Gray"))
            
            NavigationLink(destination: LoginView(isAuthUser: $isAuthUser), label: {
                Text("Войти")
                    .foregroundColor(Color("Blue"))
                    .underline()
            })
        }
    }
}
