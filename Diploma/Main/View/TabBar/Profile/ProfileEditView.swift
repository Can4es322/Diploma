import SwiftUI

struct ProfileEditView: View {
    @EnvironmentObject var viewModel: ProfileViewModel
    @Environment(\.mainWindowSize) var mainWindowSize
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            if #available(iOS 14.0, *) {
                VStack(alignment: .center) {
                    ZStack(alignment: .bottom) {
                        if viewModel.newImage != nil{
                            Image(uiImage: viewModel.newImage!)
                                .resizable()
                                .frame(width: 120, height: 120, alignment: .center)
                                .scaledToFit()
                                .clipShape(Circle())
                                
                        } else {
                            CustomAsyncImage(url: viewModel.userInfo.photo ?? "")
                                .frame(width: 120, height: 120, alignment: .center)
                                .clipShape(Circle())
                        }
                        
                        Button {
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
                    .padding(.top, 25)
                    
                    VStack(alignment: .leading, spacing: 11) {
                        Text("Почта")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.black)
                            .padding(.leading, 10)
                        
                        CustomCommonTextField(placeholder: "", text: $viewModel.userInfo.email)
                        
                        Text("Имя")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.black)
                            .padding(.leading, 10)
                        
                        CustomCommonTextField(placeholder: "", text: $viewModel.userInfo.name)
                        
                        Text("Фамилия")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.black)
                            .padding(.leading, 10)
                        
                        CustomCommonTextField(placeholder: "", text: $viewModel.userInfo.lastName)
                        
                        Text("Отчество")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.black)
                            .padding(.leading, 10)
                        
                        CustomCommonTextField(placeholder: "", text: $viewModel.userInfo.middleName)
                        
                        Text("Кафедра")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.black)
                            .padding(.leading, 10)
                        
                        CustomCommonTextField(placeholder: "", text: $viewModel.userInfo.department)
                    }
                    .padding(.top, 20)
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
                .navigationBarBackButtonHidden(true)
                .navigationBarTitle("Персональные данные", displayMode: .inline)
                .navigationBarItems(
                    leading: DismissButton(),
                    trailing: Image("Checkmark.bubble")
                        .renderingMode(.template)
                        .foregroundColor(.black)
                        .opacity(viewModel.isEditTextField ? 1 : 0)
                )
                .onChange(of: viewModel.newImage) {newValue in
                    
                }
                .sheet(isPresented: $viewModel.isEditPhoto) {
                    PhotoPicker(image: $viewModel.newImage, isPicker: $viewModel.isEditPhoto)
                }
            } else {
                // Fallback on earlier versions
            }
        }
    }
}
