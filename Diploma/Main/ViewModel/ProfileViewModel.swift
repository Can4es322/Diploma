import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var userInfo = UserInfo(name: "Александр", lastName: "Курыс", middleName: "Евгеньевич", email: "aboba@gmaol.com", photo: "https://bipbap.ru/wp-content/uploads/2017/04/0_7c779_5df17311_orig.jpg", department: "МОП ЭВМ")
    @Published var isEditTextField = false
    @Published var isEditPhoto = false
    @Published var newImage: UIImage?
}
