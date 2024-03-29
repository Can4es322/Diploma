import SwiftUI

struct BottomSheetView: View {
    @GestureState private var gestureOffset: CGFloat = 0
    @EnvironmentObject private var viewModel: RegistrationViewModel
    @Binding var authData: ResponseAuthorization
    
    var body: some View {
        GeometryReader { proxy -> AnyView in
            let height = proxy.frame(in: .global).height
            return AnyView(
                ZStack {
                    Color.white
                        .cornerRadius(30)
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color("Gray"), lineWidth: 2)
                        )
                    
                    VStack(alignment: .center, spacing: 0) {
                        Capsule()
                            .frame(width: 80, height: 4)
                            .foregroundColor(Color("Gray"))
                            .padding(.top)
                        
                        VStack(spacing: 17) {
                            Text("Заполните пожалуйста следующие данные")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.black)
                                .padding(.top, 20)
                            
                            CustomCommonTextField(placeholder: "Имя", text: $viewModel.namePerson)
                            
                            CustomCommonTextField(placeholder: "Фамилия", text: $viewModel.lastnamePerson)
                            
                            CustomCommonTextField(placeholder: "Отчество", text: $viewModel.middlenamePerson)
                            
                            HStack(alignment: .top) {
                                CustomDropDown(content: viewModel.courses, isIndex: $viewModel.courseIndex)
                                    .frame(maxWidth: 96)
                                Spacer()
                                CustomDropDown(content: viewModel.departments, isIndex: $viewModel.departmentIndex)
                                    .frame(maxWidth: 130)
                            }
                            
                            if viewModel.isErrorRegistration == true {
                                Text("Ошибка с сервером")
                                    .foregroundColor(Color("Red"))
                                    .customFontBold()
                            }

                            Spacer()
                        }
                        .padding(.top, 30)
                        
                        Spacer()
                        
                        CustomBackgroundButton(text: "Продолжить") {
                            Task {
                                authData = try await viewModel.registrationUser()
                            }
                        }
                        
                        .padding(.bottom, 40)
                        .opacity(viewModel.checkIsEmptyPersonData() ? 0.5 : 1)
                        .disabled(viewModel.checkIsEmptyPersonData())
                    }
                    .padding(.horizontal, 30)
                    .frame(maxHeight: .infinity, alignment: .top)
                }
                    .offset(y: viewModel.offset < 0 ? 0 : viewModel.offset > height - viewModel.minHeightBottomSheet ? height - viewModel.minHeightBottomSheet : viewModel.offset)
                    .gesture(DragGesture().updating($gestureOffset, body: { value, out, _ in
                        out = value.translation.height
                        Task {
                            await viewModel.onChange(value: gestureOffset)
                        }
                    }).onEnded({ value in
                        Task {
                            await viewModel.onEnd(value: value, height: height)
                        }
                    }))
            )
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}
