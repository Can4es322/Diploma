import SwiftUI
import CoreLocation

final class ProfileViewModel: ObservableObject {
    @Published var userInfo = ResponseUser(firstname: "", lastname: "", middlename: "", course: 0, department: "", avatar: nil, email: "", password: "", role: "")
    @Published var eventsAttend: [ResponseEvent] = []
    @Published var isEditPhoto = false
    @Published var newImage: UIImage?
    @Published var isActiveAlert = false
    @Published var isChangeTextFields = [false, false, false, false, false]
    
    let service: UserServiceProtocol
    let dateAndPlaceconfig = DateAndPlaceConfigurator()
    
    init(service: UserServiceProtocol = UserService()) {
        self.service = service
    }
    
    func getUserData() async throws {
        do {
            if let (data1, data2, data3) = try? await service.initializerUser() {
                if let userData = data1 {
                    await MainActor.run {
                        self.userInfo = userData
                    }
                }
                if let userAvatar = data2 {
                    await MainActor.run {
                        self.userInfo.avatar = userAvatar.imageData
                    }
                }
                if let userEvents = data3 {
                    await MainActor.run {
                        self.eventsAttend = userEvents
                        addPlaceDate()
                    }
                }
            }
        } catch {
            print(error)
        }
    }
    
    func addPlaceDate() {
        for (index, event) in eventsAttend.enumerated() {
            dateAndPlaceconfig.getLocationName(latitude: event.latitude, longitude: event.longitude) {[weak self] name in
                self?.eventsAttend[index].place = name
            }

            eventsAttend[index].date = dateAndPlaceconfig.getDate(startDate: event.startDateTime, endDate: event.endDateTime)
        }
    }
    
    func updateUser() async throws {
        do {
            let request = UserRequest(firstname: userInfo.firstname, lastname: userInfo.lastname, middlename: userInfo.middlename, course: userInfo.course, department: userInfo.department, avatar: Data(), email: userInfo.email)
            
            guard let _ = try await service.updateUser(request: request) else { return }
            guard let image = newImage?.pngData() else { return }
            guard let _ = try await service.updateAvatar(image: image) else { return }
            
        }catch {
            print(error)
        }
    }
    
    func checkActiveAlert() {
        for isChangeTextField in isChangeTextFields {
            if isChangeTextField {
                isActiveAlert = true
                return
            }
        }
        if newImage != nil {
            isActiveAlert = true
            return
        }
        isActiveAlert = false
    }
    
    func checkChangeTextFields() -> Bool {
        for isChangeTextField in isChangeTextFields {
            if isChangeTextField || newImage != nil {
                return true
            }
        }
        return false
    }
}
