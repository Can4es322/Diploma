import SwiftUI

struct EventPostView: View {
    let infoCard: ResponseEvent
    @Environment(\.mainWindowSize) private var mainWindowSize
    @EnvironmentObject private var viewModel: MainViewModel
    
    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    ArtWork()
                    
                    VStack(spacing: 12) {
                        PostInformation()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
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
                ImageView(photos: infoCard.images)
            }
        }
    }
    
    @ViewBuilder
    func ArtWork() -> some View {
        GeometryReader { proxy in
            let size = proxy.size
            let minY = proxy.frame(in: .named("SCROLL")).minY
            let progress = minY / mainWindowSize.height * 2.2
            
            CustomImageDate(imageData: infoCard.avatar)
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
                                ForEach(Array(zip(infoCard.images.indices, infoCard.images)), id: \.0) { index, photo in
                                    Button {
                                        withAnimation(.easeInOut) {
                                            viewModel.isSelectedPhotos.toggle()
                                            viewModel.selectedImageId = infoCard.images[index].imageData
                                        }
                                    } label: {
                                        if index == 3 {
                                            Text("+\(infoCard.images.count - 3)")
                                                .font(.system(size: 16, weight: .medium))
                                                .frame(width: 54, height: 54)
                                                .background(Color("Blue2"))
                                                .foregroundColor(.white)
                                                .cornerRadius(12)
                                        }
                                        if index < 3 {
                                            MiniPhoto(imageData: photo.imageData)
                                        }
                                    }
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding([.bottom, .trailing], 20)
                            
                            HStack(spacing: 10) {
                                WalkPerson(countCurrent: infoCard.countPeople, countMaxCount: infoCard.countPeopleMax, color: Color.black)
                                
                                ForEach(infoCard.tags) { value in
                                    TagPost(text: value.name)
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
        Group {
            Text(infoCard.title)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.black)
                .fixedSize(horizontal: false, vertical: true)
            
            Text(infoCard.date ?? "")
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(.black)
                .fixedSize(horizontal: false, vertical: true)
            
            Text(infoCard.description)
                .padding(.top, 8)
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(.black)
                .fixedSize(horizontal: false, vertical: true)
        
            if UserDefaults.standard.string(forKey: "role") != "ADMIN" {
                Spacer()
                if viewModel.isSignUpEvent {
                    CustomBorderButton(text: "Отписаться") {
                        Task {
                            try await viewModel.unsubscribeEvent(eventId: infoCard.id)
                        }
                    }
                } else {
                    CustomBackgroundButton(text: "Записаться") {
                        Task {
                            try await viewModel.signUpEvent(eventId: infoCard.id)
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
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
