import SwiftUI

struct BottomSheetView: View {
    @State var offset: CGFloat = 0
    @State var lastOffset: CGFloat = 0
    @GestureState var gestureOffset: CGFloat = 0
    @EnvironmentObject var viewModel: RegistrationViewModel
    let minHeightBottomSheet: CGFloat = 40
    let defaultTransform: CGFloat = 20
    
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
                                CustomDropDown(content: ["1 Курс", "2 Курс", "3 Курс", "4 Курс"])
                                    .frame(maxWidth: 96)
                                Spacer()
                                CustomDropDown(content: ["МОП ЭВМ", "ВМ", "БИТ", "САПР", "ВТ", "ИМС", "ИАСБ", "ИБТС", "БИпЖ", "СПУ", "САИТ"])
                                    .frame(maxWidth: 130)
                            }
                            Spacer()
                        }
                        
                        Spacer()
                        
                        CustomBackgroundButton(text: "Продолжить") {
                            
                        }
                        .padding(.bottom, 40)
                        .opacity(viewModel.checkIsEmptyPersonData() ? 0.5 : 1)
                        .disabled(viewModel.checkIsEmptyPersonData())
                    }
                    .padding(.horizontal, 30)
                    .frame(maxHeight: .infinity, alignment: .top)
                }
                    .offset(y: offset < 0 ? 0 : offset > height - minHeightBottomSheet ? height - minHeightBottomSheet : offset)
                .gesture(DragGesture().updating($gestureOffset, body: { value, out, _ in
                    out = value.translation.height
                    onChange()
                }).onEnded({ value in
                    
                    withAnimation {
                        if offset > defaultTransform && offset < height / 3 * 2 && lastOffset < height / 3 * 2{
                            offset = height - minHeightBottomSheet
                            lastOffset = offset
                        }
                        
                        if offset < height - minHeightBottomSheet - defaultTransform {
                            offset = 0
                            lastOffset = offset
                        }
                    }
                }))
            )
        }
        .edgesIgnoringSafeArea(.bottom)
    }
    
    func onChange() {
        DispatchQueue.main.async {
            print(self.offset)
            self.offset = gestureOffset + lastOffset
        }
    }
}
