import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewModel()
    @Environment(\.mainWindowSize) var mainWindowSize

    let tags = ["Наука", "Мастер-класс", "Конференция", "Театр", "Спорт", "Тренинг", "Концерт"]
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Text("Мероприятия")
                .padding(.horizontal, 20)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 28, weight: .bold))
                .padding(.top, mainWindowSize.height / 21)
            
            HStack {
                TextField("Поиск", text: $viewModel.inputSearch)
                
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color("Gray"))
            }
            
            .padding(.vertical, 9)
            .padding(.leading, 13)
            .padding(.trailing, 15)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .strokeBorder(Color("Gray"), lineWidth: 2)
            )
            .frame(maxWidth: .infinity)
            .frame(height: 40)
            .padding(.top, 20)
            .padding(.horizontal, 20)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(Array(zip(tags.indices, tags)), id: \.0) { index, element in
                        TagEvent(text: element, index: index, activeTags: $viewModel.activeTags)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 12)
            }
            
            Spacer()
        }
        
    }
}
