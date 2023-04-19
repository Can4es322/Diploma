import SwiftUI

struct AddImageView: View {
    let place: Place
    let event: Event
    @State var isPhotoPickerSheet = false
    @State var imageData = EventImage(images: [], avatar: nil)
    
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            
            if let avatar = imageData.avatar {
                Image(uiImage: avatar)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(12)
                    .frame(height: 400)
                   
                
                HStack(spacing: 10) {
                    ForEach(imageData.images, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 90, height: 90)
                            .cornerRadius(12)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 20)
                
                CustomBackgroundButton(text: "Зарегестрировать") {
                    
                }
                .padding(.top, 10)
                
            } else {
                Text("Нет Изображения")
                    .customFontBold()
                    .frame(maxWidth: .infinity)
                    .frame(height: 400)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color("Gray"), lineWidth: 2)
                    )
            }
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("Добавить Изображения", displayMode: .inline)
        .navigationBarItems(
            leading: DismissButton(),
            trailing: Button {
                isPhotoPickerSheet.toggle()
            } label: {
                Image(systemName: "plus")
                    .font(.system(size: 20))
                    .foregroundColor(.black)
            }
        )
        .sheet(isPresented: $isPhotoPickerSheet) {
            if #available(iOS 14, *) {
                PhotoPickerImages(imagesData: $imageData, isPresented: $isPhotoPickerSheet)
            } else {
                ImagePicker()
            }
        }
    }
}
