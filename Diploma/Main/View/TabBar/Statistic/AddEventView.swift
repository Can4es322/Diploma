import SwiftUI

struct AddEventView: View {
    @StateObject var viewModel = AddEventViewModel()
    @Environment(\.mainWindowSize) private var mainWindowSize
    private let tags = ["Наука", "Мастер-класс", "Конференция", "Театр", "Спорт", "Тренинг", "Концерт"]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 6) {
                Text("Название")
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.black)
                
                CustomCommonTextField(placeholder: "", text: $viewModel.eventInfo.name)

                Text("Описание")
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.black)
                    .padding(.top, 13)
                
                CustomCommonTextField(placeholder: "", text: $viewModel.eventInfo.description)
                
                Text("Количество")
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.black)
                    .padding(.top, 13)
                
                CustomCommonTextField(placeholder: "", text: $viewModel.eventInfo.countPerson)
                
                DatePicker("Выбрать дату", selection: $viewModel.eventInfo.date, displayedComponents: [.date, .hourAndMinute])
                    .datePickerStyle(.automatic)
                    .font(.system(size: 16, weight: .regular))
                    .padding(.top, 26)
                
                
                Text("Категории")
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.top, 13)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.black)
                
                AddCategory()
                    .padding(.top, 13)
                
                NavigationLink(destination: AddAddressView(), isActive: $viewModel.isNextView) {
                    CustomBackgroundButton(text: "Далее") {
                        viewModel.isNextView.toggle()
                    }
                    .padding(.top, 40)
                }
                .disabled(viewModel.checkIsEmptyAddEvent())
                .opacity(viewModel.checkIsEmptyAddEvent() ? 0.5 : 1)
            }
            .padding(.horizontal, 20)
            .padding(.top, mainWindowSize.height / 23)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("Добавить мероприятие", displayMode: .inline)
        .navigationBarItems(
            leading: DismissButton()
        )
    }
}

extension AddEventView {
    @ViewBuilder
    func AddCategory() -> some View {
        VStack(spacing: 12) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    Button {
                        withAnimation {
                            viewModel.isCategoryTap.toggle()
                        }
                    } label: {
                        Image(systemName: "plus")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 10)
                            .background(Color("Gray1"))
                            .cornerRadius(10)
                    }
                    
                    ForEach(Array(zip(viewModel.isCategoryTaps.indices, viewModel.isCategoryTaps)), id: \.0) { index, element in
                        if element {
                            TagPost(text: tags[index])
                        }
                    }
                }
            }
            
            if viewModel.isCategoryTap {
                ForEach(Array(zip(tags.indices, tags)), id: \.0) { index, element in
                    AddTag(text: element, isTap: $viewModel.isCategoryTaps[index], tags: $viewModel.eventInfo.tags)
                }
            }
        }
    }
}