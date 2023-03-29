import SwiftUI

struct ProfileView: View {
    @Environment(\.mainWindowSize) private var mainWindowSize
    @StateObject private var viewModel = ProfileViewModel()

    var body: some View {
        VStack(spacing: 0) {
            Header()
            
            Avatar()
                .padding(.top, mainWindowSize.height / 21)
            
            Text("Посещенные мероприятия")
                .frame(maxWidth: .infinity, alignment: .center)
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(.black)
                .padding(.top, mainWindowSize.height / 21)
            
            VisitedEnets()
                .padding(.top, mainWindowSize.height / 24)
        }
        .padding(.horizontal, 20)
        .padding(.top, mainWindowSize.height / 21)
        .navigationBarHidden(true)
    }
}

extension ProfileView {
    @ViewBuilder
    func Header() -> some View {
        HStack {
            Text("Профиль")
                .customFontBold()
            
            Spacer()
            
            HStack(spacing: 16) {
                NavigationLink (destination: ProfileEditView().environmentObject(viewModel)) {
                    Image(systemName: "pencil")
                        .foregroundColor(.black)
                }
                
                Button {
                    
                } label: {
                    Image(systemName: "ipad.and.arrow.forward")
                        .foregroundColor(.black)
                }
            }
            .padding(.horizontal, 4)
            .padding(.vertical, 2)
            .background(Color("Gray4"))
            .cornerRadius(6)
        }
    }
    
    @ViewBuilder
    func Avatar() -> some View {
        HStack(spacing: 20) {
            CustomAsyncImage(url: viewModel.userInfo.photo ?? "")
                .frame(width: 100, height: 100, alignment: .center)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 8) {
                Group {
                    Text(viewModel.userInfo.lastName) +
                    Text(" ") +
                    Text(viewModel.userInfo.name) +
                    Text(" ") +
                    Text(viewModel.userInfo.middleName)
                }
                .customFontBoldMid()
                
                Text(viewModel.userInfo.email)
                    .font(.system(size: 14, weight: .medium))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    @ViewBuilder
    func VisitedEnets() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                ForEach(mockEvents) { element in
                    VisitedEvents(eventsInfo: element)
                }
            }
        }
    }
}
