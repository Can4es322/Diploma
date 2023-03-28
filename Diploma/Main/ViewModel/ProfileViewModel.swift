import SwiftUI

final class ProfileViewModel: ObservableObject {
    @Published var userInfo = UserInfo(name: "Александр", lastName: "Курыс", middleName: "Евгеньевич", email: "aboba@gmaol.com", photo: "https://bipbap.ru/wp-content/uploads/2017/04/0_7c779_5df17311_orig.jpg", department: "МОП ЭВМ")
    @Published var isEditPhoto = false
    @Published var newImage: UIImage?
    @Published var isActiveAlert = false
    @Published var isChangeTextFields = [false, false, false, false, false]
    
    func checkActiveAlert() {
        for isChangeTextField in isChangeTextFields {
            if isChangeTextField {
                isActiveAlert = true
                return
            }
        }
        isActiveAlert = false
    }
    
    func checkChangeTextFields() -> Bool {
        for isChangeTextField in isChangeTextFields {
            if isChangeTextField {
                return true
            }
        }
        return false
    }
}
