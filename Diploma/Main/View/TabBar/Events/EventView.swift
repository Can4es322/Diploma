import SwiftUI
import Combine

struct EventView: View {
    let role: String
    @StateObject private var viewModel = MainViewModel()
    @Environment(\.mainWindowSize) private var mainWindowSize
    
    var body: some View {
        if #available(iOS 14.0, *) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center, spacing: 0) {
                    Header()
                    
                    if viewModel.events.isEmpty {
                        Spacer(minLength: mainWindowSize.height / 2.5)
                        CustomProgressBar()
                        Spacer(minLength: mainWindowSize.height / 2.5)
                    } else {
                        EventTags()
                            .padding(.top, 12)
                        
                        EventCards()
                            .padding(.top, 11)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, mainWindowSize.height / 21)
            }
            .frame(maxHeight: .infinity)
            .navigationBarHidden(true)
            .onAppear() {
                Task {
                    try await viewModel.getEvents()
                }
            }
            .onChange(of: viewModel.activeTags, perform: { newValue in
                if viewModel.activeTags.isEmpty {
                    Task {
                        try await viewModel.getEvents()
                    }
                }
            })
            .onChange(of: viewModel.inputSearch, perform: { newValue in
                if viewModel.inputSearch == "" {
                    Task {
                        try await viewModel.getEvents()
                    }
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        if viewModel.inputSearch == newValue {
                            Task {
                                try await viewModel.getSearchEvents()
                            }
                        }
                    }
                }
            })
        } else {
            // Fallback on earlier versions
        }
    }
}

extension EventView {
    @ViewBuilder
    func Header() -> some View {
        HStack {
            HStack {
                Text("Мероприятия")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .customFontBold()
                Spacer()
                
                Button {
                    Task {
                        try await viewModel.getSearchTagEvents()
                    }
                    
                }label: {
                    Text("Применить")
                        .padding(.horizontal, 6)
                        .frame(height: 30)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(viewModel.activeTags.isEmpty ? Color("Gray2") : .white)
                        .background(viewModel.activeTags.isEmpty ? Color("Gray") : Color("Blue"))
                        .cornerRadius(12)
                }
                .disabled(viewModel.activeTags.isEmpty)
            }
            
            Spacer()
            
            if role == "ADMIN" {
                NavigationLink(destination: AddEventView().environmentObject(viewModel)) {
                    Image(systemName: "plus")
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                }
            }
        }
        
        SeacrhTextField(inputText: $viewModel.inputSearch, placeholderText: "Поиск")
        
    }
    
    @ViewBuilder
    func EventTags() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(Array(zip(viewModel.tags.indices, viewModel.tags)), id: \.0) { index, element in
                    TagEvent(text: element, activeTags: $viewModel.activeTags)
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
