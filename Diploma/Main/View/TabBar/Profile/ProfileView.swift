import SwiftUI

struct ProfileView: View {
    @Environment(\.mainWindowSize) var mainWindowSize
    @StateObject var viewModel = ProfileViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Профиль")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.black)
                
                Spacer()
                
                HStack(spacing: 16) {
                    Button {
                        
                    } label: {
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
            .padding(.top, mainWindowSize.height / 21)

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
                    .font(.system(size: 20, weight: .bold))
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundColor(.black)
                    
                    Text(viewModel.userInfo.email)
                        .font(.system(size: 14, weight: .medium))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.top, mainWindowSize.height / 21)

            Text("Посещенные мероприятия")
                .frame(maxWidth: .infinity, alignment: .center)
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(.black)
                .padding(.top, mainWindowSize.height / 21)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    ForEach(mockEvents) { element in
                        VisitedEvents(eventsInfo: element)
                    }
                }
            }
            .padding(.top, mainWindowSize.height / 24)
        }
        .padding(.horizontal, 20)
        .navigationBarHidden(true)
    }
}
