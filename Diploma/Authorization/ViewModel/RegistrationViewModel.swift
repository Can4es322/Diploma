import SwiftUI

final class RegistrationViewModel: ObservableObject {
    @Published var loginText = "@"
    @Published var passwordText = "f"
    @Published var confirmPassword = "f"
    @Published var isErrorLogin: Bool? = nil
    @Published var isPolitical = true
    @Published var namePerson = "a"
    @Published var lastnamePerson = "a"
    @Published var middlenamePerson = "a"
    @Published var isBottomSheet = false
    @Published var offset: CGFloat = 0
    @Published var lastOffset: CGFloat = 0
    let minHeightBottomSheet: CGFloat = 100
    let defaultTransform: CGFloat = 20
    
    func checkIsEmptyTextFields() -> Bool {
        return loginText.isEmpty || passwordText.isEmpty || confirmPassword.isEmpty || !isPolitical
    }
    
    func checkIsCorrectEmail() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isErrorLogin = self.loginText.contains("@")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.isBottomSheet = self.isErrorLogin ?? false
        }
    }
    
    func checkIsEmptyPersonData() -> Bool {
        return namePerson.isEmpty || lastnamePerson.isEmpty || middlenamePerson.isEmpty
    }
    
    func registrationUser() -> Bool {
        return true
    }
    
    func onChange(value: CGFloat) async {
        await MainActor.run {
            self.offset = value + self.lastOffset
        }
    }
    
    func onEnd(value: DragGesture.Value, height: CGFloat) async {
        await MainActor.run {
            withAnimation {
                if self.offset > self.defaultTransform && self.offset < height / 3 * 2 && self.lastOffset < height / 3 * 2{
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
