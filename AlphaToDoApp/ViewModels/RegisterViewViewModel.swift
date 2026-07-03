import Foundation
import FirebaseAuth
import FirebaseFirestore

class RegisterViewViewModel: ObservableObject {

    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""

    init() {}

    func register() {
        guard validate() else {
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            
            // 1. Hata kontrolü
            if let error = error {
                DispatchQueue.main.async {
                    self?.errorMessage = error.localizedDescription
                }
                return
            }

            // 2. Başarılıysa userId al
            guard let userId = result?.user.uid else {
                return
            }

            print("Kullanıcı oluşturuldu. UID: \(userId)")

            // 3. Firestore'a kaydı TEK SEFERDE tetikle
            self?.insertUserRecord(id: userId)
        }
    }

    private func insertUserRecord(id: String) {
        let newUser = User(id: id, name: name, email: email, joined: Date().timeIntervalSince1970)
        
        let db = Firestore.firestore()
        
        // Veritabanına yazma işlemi
        db.collection("users")
            .document(id)
            .setData(newUser.asDictionary()) { error in
                if let error = error {
                    print("Firestore kayıt hatası: \(error.localizedDescription)")
                } else {
                    print("Kullanıcı Firestore'a başarıyla kaydedildi.")
                }
            }
    }

    private func validate() -> Bool {
        errorMessage = ""

        guard !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              !password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            errorMessage = "Lütfen tüm alanları doldurunuz."
            return false
        }

        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Lütfen geçerli bir e-posta adresi giriniz."
            return false
        }

        guard password.count >= 6 else {
            errorMessage = "Şifre en az 6 karakter olmalıdır."
            return false
        }

        return true
    }
}
