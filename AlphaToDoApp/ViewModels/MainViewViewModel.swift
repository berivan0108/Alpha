import FirebaseAuth
import Foundation

class MainViewViewModel: ObservableObject {
    @Published var currentUserId: String = ""
    
    // Auth.auth().currentUser olup olmadığını kontrol eden değişken
    private var handler: AuthStateDidChangeListenerHandle?
    
    init() {
        // Firebase Auth durumunu dinlemeye başla
        self.handler = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            
            // Kullanıcı değiştiğinde arayüzü güncelle
            DispatchQueue.main.async {
                self?.currentUserId = user?.uid ?? ""
            }
        }
    }
    
    // Uygulama kapatılırken dinleyiciyi temizlemek iyi bir pratiktir
    deinit {
        if let handler = handler {
            Auth.auth().removeStateDidChangeListener(handler)
        }
    }
    
    public var isSignedIn: Bool {
        return Auth.auth().currentUser != nil
    }
}
