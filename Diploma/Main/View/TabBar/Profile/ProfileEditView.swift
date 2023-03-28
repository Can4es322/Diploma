import SwiftUI

struct ProfileEditView: View {
    @EnvironmentObject private var viewModel: ProfileViewModel
    @Environment(\.mainWindowSize) private var mainWindowSize
    @Environment(\.presentationMode) private var presentation
    private let nameTextFields = ["Почта", "Имя", "Фамилия", "Отчество", "Кафедра"]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center) {
                
                Avatar()
                    .padding(.top, 25)
                
                EditTextFields()
                    .padding(.top, 20)
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("Персональные данные", displayMode: .inline)
            .navigationBarItems(
                leading: Button {
                    UIApplication.shared.endEditing()
                    viewModel.checkActiveAlert()
                    if !viewModel.isActiveAlert {
                        presentation.wrappedValue.dismiss()
                    }
                } label: {
                    Image(systemName: "arrow.backward")
                        .resizable()
                        .customFontBoldMid()
                },
                trailing: Button {
                    // Запрос на сохранение данных
                } label: {
                    Image("Checkmark.bubble")
                        .renderingMode(.template)
                        .foregroundColor(.black)
                        .opacity(viewModel.checkChangeTextFields() ? 1 : 0)
                }
            )
            .alert(isPresented: $viewModel.isActiveAlert) {
                Alert(
                    title: Text("Вы точно хотите вернуться назад?"),
                    message: Text("Данные не сохранятся"),
                    primaryButton: .destructive(Text("Да"), action: {
                        presentation.wrappedValue.dismiss()
                    }),
                    secondaryButton: .cancel(Text("Нет"))
                )
            }
            .sheet(isPresented: $viewModel.isEditPhoto) {
                if #available(iOS 14, *) {
                    PhotoPicker(image: $viewModel.newImage, isPicker: $viewModel.isEditPhoto)
                } else {
                    ImagePicker()
                }
            }
        }
    }
}

extension ProfileEditView {
    @ViewBuilder
    func Avatar() -> some View {
        ZStack(alignment: .bottom) {
            if viewModel.newImage != nil {
                Image(uiImage: viewModel.newImage!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 120, alignment: .center)
                    .clipShape(Circle())
            } else {
                CustomAsyncImage(url: viewModel.userInfo.photo ?? "")
                    .frame(width: 120, height: 120, alignment: .center)
                    .clipShape(Circle())
            }
            
            Button {
                UIApplication.shared.endEditing()
                viewModel.isEditPhoto.toggle()
            } label: {
                Circle()
                    .frame(width: 34, height: 34)
                    .foregroundColor(Color("White"))
                    .overlay(
                        Image(systemName: "camera.fill")
                            .frame(width: 21, height: 17)
                            .foregroundColor(.black)
                    )
                    .offset(y: 14)
            }
        }
    }
    
    @ViewBuilder
    func EditTextFields() -> some View {
        VStack(alignment: .leading, spacing: 11) {

            Text("Почта")
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(.black)
                .padding(.leading, 10)
            
            CustomCommonEditTextField(placeholder: "", text: $viewModel.userInfo.email, isChangeColor: $viewModel.isChangeTextFields[0])
            
            Text("Имя")
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(.black)
                .padding(.leading, 10)
            
            CustomCommonEditTextField(placeholder: "", text: $viewModel.userInfo.name, isChangeColor: $viewModel.isChangeTextFields[1])
            
            Text("Фамилия")
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(.black)
                .padding(.leading, 10)
            
            CustomCommonEditTextField(placeholder: "", text: $viewModel.userInfo.lastName, isChangeColor: $viewModel.isChangeTextFields[2])
            
            Text("Отчество")
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(.black)
                .padding(.leading, 10)
            
            CustomCommonEditTextField(placeholder: "", text: $viewModel.userInfo.middleName, isChangeColor: $viewModel.isChangeTextFields[3])
            
            Text("Кафедра")
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(.black)
                .padding(.leading, 10)
            
            CustomCommonEditTextField(placeholder: "", text: $viewModel.userInfo.department, isChangeColor: $viewModel.isChangeTextFields[4])
        }
    }
}
