import SwiftUI
import Combine

struct AddAddressView: View {
    @EnvironmentObject private var viewModel: AddEventViewModel
    @Environment(\.mainWindowSize) private var mainWindowSize
    @Binding var rootIsActive: Bool
    
    var body: some View {
        if #available(iOS 14.0, *) {
            ZStack(alignment: .top) {
                MapAddAddress(viewModel: viewModel)
                
                VStack(spacing: 0) {
                    SeacrhTextField(inputText: $viewModel.inputSearch, placeholderText: "Адрес")
                    if !viewModel.places.isEmpty && viewModel.inputSearch != "" {
                        ScrollView {
                            VStack(spacing: 15) {
                                ForEach(viewModel.places) { place in
                                    Text(place.place?.name ?? "")
                                        .lineLimit(nil)
                                        .foregroundColor(.black)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.leading)
                                        .onTapGesture {
                                            viewModel.tapPlace(place: place)
                                        }
                                    Divider()
                                }
                            }
                            .padding(.top)
                        }
                        .frame(maxHeight: 300)
                        .background(Color.white)
                        .cornerRadius(12)
                    }
                }
                .padding(.horizontal, 20)
                
                Text(viewModel.currentPlace.place?.name ?? viewModel.defaultName)
                    .padding(.horizontal, 8)
                    .frame(maxWidth: .infinity)
                    .frame(minHeight: 40)
                    .background(Color.white.opacity(0.7))
                    .cornerRadius(12)
                    .customFontBoldMid()
                    .offset(y: mainWindowSize.height / 1.5)
                    .lineLimit(nil)
                    .padding(.horizontal, 20)
                    .multilineTextAlignment(.center)
                
                NavigationLink(destination: AddImageView(rootIsActive: $rootIsActive).environmentObject(viewModel)) {
                    Text("Далее")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(.white)
                        .frame(width: 100, height: 44)
                        .background(
                            Color("Gray1")
                        )
                        .cornerRadius(12)
                }
                .isDetailLink(false)
                .offset(x: mainWindowSize.width / 3 ,y: mainWindowSize.height / 1.2)
            }
            .onChange(of: viewModel.inputSearch) { newValue in
                Task {
                    try await Task.sleep(nanoseconds: 3_000_000)
                    await MainActor.run {
                        if newValue == viewModel.inputSearch {
                            print(newValue)
                            viewModel.searchLocationPoint()
                        }
                    }
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("Добавить Адрес", displayMode: .inline)
            .navigationBarItems(
                leading: DismissButton()
            )
        } else {
           
        }
    }
}
