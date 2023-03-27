import SwiftUI

struct EventPostView: View {
    let infoCard: CardEventInfo
    @Environment(\.mainWindowSize) var mainWindowSize
    @EnvironmentObject var viewModel: MainViewModel
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                CustomAsyncImage(url: infoCard.avatar)
                    .frame(maxWidth: .infinity)
                
                LinearGradient(colors: [Color.white, Color("White1").opacity(0.1)], startPoint: .bottom, endPoint: .top)
                
                HStack(spacing: 12) {
                    ForEach(Array(zip(infoCard.photos.indices, infoCard.photos)), id: \.0) { index, photo in
                        Button {
                            withAnimation(.easeInOut) {
                                viewModel.isSelectedPhotos.toggle()
                                viewModel.selectedImageId = infoCard.photos[index]
                            }
                        } label: {
                            if index == 3 {
                                Text("+\(infoCard.photos.count - 3)")
                                    .font(.system(size: 16, weight: .medium))
                                    .frame(width: 54, height: 54)
                                    .background(Color("Blue2"))
                                    .foregroundColor(.white)
                                    .cornerRadius(12)
                            }
                            if index < 3 {
                                MiniPhoto(photo: photo)
                            }
                        }
                    }
                }
                .offset(x: 30, y: -58)
                
                HStack(spacing: 10) {
                    WalkPerson(countCurrent: infoCard.countCurrentUser, countMaxCount: infoCard.countMaxUser, color: Color.black)
                    
                    ForEach(infoCard.tags, id: \.self) { value in
                        TagPost(text: value)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .offset(x: mainWindowSize.width / 3 + 10, y: 10)
            }
            .frame(maxWidth: .infinity)
            .frame(height: mainWindowSize.height / 2.1)
            
            VStack(alignment: .leading, spacing: 12) {
                Text(infoCard.title)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.black)
                    .fixedSize(horizontal: false, vertical: true)
                
                Text(infoCard.date)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.black)
                    .fixedSize(horizontal: false, vertical: true)
                
                Text(infoCard.description)
                    .padding(.top, 10)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.black)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding([.horizontal, .top], 20)
            
            Spacer()
        }
        .overlay(
            ZStack {
                if viewModel.isSelectedPhotos {
                    ImageView(photos: infoCard.photos)
                }
            }
        )
        .edgesIgnoringSafeArea(.top)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: DismissButton()
        )
    }
}
