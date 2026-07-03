import Foundation
import FirebaseAuth

class LoginViewViewModel: ObservableObject {

    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""

    init() {}

    func login() {
        guard validate() else {
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self else {
                return
            }

            if let error = error {
                self.errorMessage = error.localizedDescription
                return
            }

            // Giriş başarılı
        }
        // Login işlemi burada yapılacak
    }

    func validate() -> Bool {

        guard !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              !password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            errorMessage = "Lütfen tüm alanları doldurun."
            return false
        }

        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Lütfen geçerli bir email adresi girin."
            return false
        }

        return true
    }
}
