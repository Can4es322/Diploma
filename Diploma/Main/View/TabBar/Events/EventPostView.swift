import SwiftUI

struct EventPostView: View {
    let infoCard: CardEventInfo
    @Environment(\.mainWindowSize) var mainWindowSize
    @EnvironmentObject var viewModel: MainViewModel
    
    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0){
                    ArtWork()
                    
                    VStack(alignment: .leading, spacing: 12) {
                        PostInformation()
                    }
                    .padding([.horizontal, .top], 20)
                    
                    Spacer()
                }
                .overlay(
                    HeaderView()
                    ,alignment: .top
                )
            }
            .disabled(viewModel.isSelectedPhotos)
            .navigationBarHidden(true)
            .coordinateSpace(name: "SCROLL")
            
            if viewModel.isSelectedPhotos {
                ImageView(photos: infoCard.photos)
            }
        }
    }
    
    @ViewBuilder
    func ArtWork() -> some View {
        GeometryReader { proxy in
            let size = proxy.size
            let minY = proxy.frame(in: .named("SCROLL")).minY
            let progress = minY / mainWindowSize.height * 2.2
            
            CustomAsyncImage(url: infoCard.avatar)
                .frame(width: size.width, height: size.height + (minY > 0 ? minY : 0))
                .clipped()
                .overlay (
                    ZStack(alignment: .bottom) {
                        Rectangle()
                            .fill(.linearGradient(colors: [Color.white.opacity(0 - progress),
                                                           Color("White1").opacity(0.15 - progress),
                                                           Color("White1").opacity(0.25 - progress),
                                                           Color("White1").opacity(0.55 - progress),
                                                           Color("White1").opacity(0.85 - progress),
                                                           Color("White1").opacity(1),
                                                          ], startPoint: .top, endPoint: .bottom))
                        
                        VStack {
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
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.bottom, 20)
                            
                            HStack(spacing: 10) {
                                WalkPerson(countCurrent: infoCard.countCurrentUser, countMaxCount: infoCard.countMaxUser, color: Color.black)
                                
                                ForEach(infoCard.tags, id: \.self) { value in
                                    TagPost(text: value)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                        }
                        .frame(maxHeight: .infinity, alignment: .bottom)
                        .overlay(
                            Color("White1").opacity(-progress > 0.85 ? 1 : 0)
                        )
                        .offset(y: minY < 0 ? minY : 0)
                    }
                )
                .offset(y: -minY)
        }
        .frame(height: mainWindowSize.height / 2.2)
    }
    
    @ViewBuilder
    func PostInformation() -> some View {
        Text(infoCard.title)
            .font(.system(size: 24, weight: .bold))
            .foregroundColor(.black)
            .fixedSize(horizontal: false, vertical: true)
        
        Text(infoCard.date)
            .font(.system(size: 16, weight: .regular))
            .foregroundColor(.black)
            .fixedSize(horizontal: false, vertical: true)
        
        Text(infoCard.description)
            .padding(.top, 8)
            .font(.system(size: 16, weight: .regular))
            .foregroundColor(.black)
            .fixedSize(horizontal: false, vertical: true)
    }
    
    @ViewBuilder
    func HeaderView() -> some View {
        GeometryReader { proxy in
            let minY = proxy.frame(in: .named("SCROLL")).minY
            
            DismissButton()
                .frame(width: 20, height: 17)
                .padding(.leading, 20)
                .padding(.top, mainWindowSize.height / 18)
                .offset(y: -minY)
        }
        .frame(height: 34)
    }
}
