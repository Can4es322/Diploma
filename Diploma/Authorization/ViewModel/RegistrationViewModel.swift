import SwiftUI

enum Department: String, CaseIterable {
    case MOP
    case VM
    case BIT
    case SAPR
    case VT
    case IMC
    case IASB
    case IBTS
    case PIBZ
    case CPY
    case SAIT
    
    mutating func transformation(_ index: Int) {
        var count = 0
        for department in Department.allCases {
            if count == index {
                self = department
            }
            count += 1
        }
    }
}

final class RegistrationViewModel: ObservableObject {
    @Published var loginText = "can@gmail.com"
    @Published var passwordText = "123"
    @Published var confirmPassword = "123"
    @Published var isPolitical = true
    @Published var namePerson = "Александр"
    @Published var lastnamePerson = "Курыс"
    @Published var middlenamePerson = "Евгеньевич"
    @Published var courseIndex = 0
    @Published var departmentIndex = 0
    
    @Published var isErrorRegistration: Bool? = nil
    @Published var isErrorLogin: Bool? = nil
    @Published var offset: CGFloat = 0
    @Published var lastOffset: CGFloat = 0
    let minHeightBottomSheet: CGFloat = 100
    let defaultTransform: CGFloat = 20
    
    let courses = ["1 Курс", "2 Курс", "3 Курс", "4 Курс"]
    let departments = ["МОП ЭВМ", "ВМ", "БИТ", "САПР", "ВТ", "ИМС", "ИАСБ", "ИБТС", "БИпЖ", "СПУ", "САИТ"]
    let service: AuthorizationServiceProtocol
    var responseAuthorization: ResponseAuthorization?
    var currentDepartment: Department = .MOP
    
    init(service: AuthorizationServiceProtocol = AuthorizationService()) {
        self.service = service
    }
    
    func checkIsEmptyTextFields() -> Bool {
        return loginText.isEmpty || passwordText.isEmpty || confirmPassword.isEmpty || !isPolitical
    }
    
    func checkIsCorrectEmail() async throws {
        if loginText.contains("@") {
            let result = try await service.checkEmail(email: loginText)
            
            await MainActor.run {
                isErrorLogin = !(result ?? false)
            }
 
        } else {
            await MainActor.run {
                isErrorLogin = false
            }
        }
    }
    
    func checkIsEmptyPersonData() -> Bool {
        return namePerson.isEmpty || lastnamePerson.isEmpty || middlenamePerson.isEmpty
    }
    
    func registrationUser() async throws -> ResponseAuthorization {
        currentDepartment.transformation(departmentIndex)
        do {
            responseAuthorization = try await service.registration(request:
                                                                    RequestRegistration(email: loginText,
                                                                                        password: passwordText,
                                                                                        firstname: namePerson,
                                                                                        lastname: lastnamePerson,
                                                                                        middlename: middlenamePerson,
                                                                                        department: currentDepartment.rawValue,
                                                                                        course: courseIndex + 1))
        } catch {
            await MainActor.run(body: {
                isErrorRegistration = true
            })
        }
        
        return responseAuthorization ?? ResponseAuthorization(token: "", role: "")
    }
    
    func onChange(value: CGFloat) async {
        await MainActor.run {
            self.offset = value + self.lastOffset
        }
    }
    
    func onEnd(value: DragGesture.Value, height: CGFloat) async {
        await MainActor.run {
            withAnimation {
                if self.offset > self.defaultTransform && self.offset < height / 3 * 2 && self.lastOffset < height / 3 * 2 {
                    self.offset = height - self.minHeightBottomSheet
                    self.lastOffset = self.offset
                }
                
                if self.offset < height - self.minHeightBottomSheet - self.defaultTransform {
                    self.offset = 0
                    self.lastOffset = self.offset
                }
            }
        }
    }
}
