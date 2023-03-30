import SwiftUI

struct EventView: View {
    let role: Role
    @StateObject private var viewModel = MainViewModel()
    @Environment(\.mainWindowSize) private var mainWindowSize
    private let tags = ["Наука", "Мастер-класс", "Конференция", "Театр", "Спорт", "Тренинг", "Концерт"]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center, spacing: 0) {
                Header()
                
                EventTags()
                    .padding(.top, 12)
                
                EventCards()
                    .padding(.top, 11)
            }
            .padding(.horizontal, 20)
            .padding(.top, mainWindowSize.height / 21)
        }
        .navigationBarHidden(true)
    }
}

extension EventView {
    @ViewBuilder
    func Header() -> some View {
        HStack {
            Text("Мероприятия")
                .frame(maxWidth: .infinity, alignment: .leading)
                .customFontBold()
            
            Spacer()
            
            if role == .admin {
                Button {
                    
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                }
            }
        }
        
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
    }
    
    @ViewBuilder
    func EventTags() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(Array(zip(tags.indices, tags)), id: \.0) { index, element in
                    TagEvent(text: element, index: index, activeTags: $viewModel.activeTags)
                }
            }
        }
    }
    
    @ViewBuilder
    func EventCards() -> some View {
        VStack(spacing: 10) {
            ForEach(viewModel.events) { element in
                CardEvent(infoCard: element)
                    .environmentObject(viewModel)
            }
        }
        .frame(maxWidth: .infinity)
    }
}
