import SwiftUI

struct ImageView: View {
    let photos: [String]
    @EnvironmentObject private var viewModel: MainViewModel
    @Environment(\.mainWindowSize) private var mainWindowSize
    @GestureState private var dragingOffset: CGSize = .zero
    
    var body: some View {
        ZStack(alignment: .center) {
            Color.black
                .opacity(viewModel.bgOpacity)
            
            TabBarImages()
                .overlay(
                    Button {
                        viewModel.isSelectedPhotos.toggle()
                    } label: {
                        Image(systemName: "multiply")
                            .resizable()
                            .frame(width: 16, height: 16)
                            .padding()
                            .foregroundColor(Color("Gray"))
                            .background(Color.white.opacity(0.3))
                            .clipShape(Circle())
                    }
                        .padding(.top, 40)
                        .padding(.trailing, 10)
                    ,alignment: .topTrailing
                    
                )
        }
        .onAppear() {
            viewModel.imageViewerOffset = .zero
        }
        .gesture(DragGesture().updating($dragingOffset, body: { value, outValue, _ in
            outValue = value.translation
            Task {
                await viewModel.onChange(value: dragingOffset)
            }
        })
            .onEnded({ value in
                Task {
                    await viewModel.onEnd(value: value)
                }
            })
        )
        .frame(maxWidth: mainWindowSize.width)
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.all)
    }
}

extension ImageView {
    @ViewBuilder
    func TabBarImages() -> some View {
        if #available(iOS 14.0, *) {
            TabView(selection: $viewModel.selectedImageId) {
                ForEach(photos, id: \.self) { photo in
                    CustomAsyncImage(url: photo)
                        .frame(width: mainWindowSize.width, height: mainWindowSize.height / 2)
                        .clipped()
                        .tag(photo)
                        .offset(y: viewModel.imageViewerOffset.height)
                        .scaleEffect(viewModel.selectedImageId == photo ? (viewModel.imageScale > 1 ? viewModel.imageScale : 1) : 1)
                        .gesture(MagnificationGesture().onChanged({ value in
                            viewModel.imageScale = value
                        }).onEnded({ _ in
                            withAnimation(.spring()) {
                                viewModel.imageScale = 1
                            }
                        })
                            .simultaneously(with: TapGesture(count: 2).onEnded({ _ in
                                withAnimation {
                                    viewModel.imageScale = viewModel.imageScale > 1 ? 1 : 4
                                }
                            }))
                        )
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        } else {
            // Fallback on earlier versions
        }
    }
}
