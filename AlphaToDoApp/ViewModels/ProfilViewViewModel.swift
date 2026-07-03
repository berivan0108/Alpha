import FirebaseAuth
import FirebaseFirestore
import Foundation

class ProfilViewViewModel: ObservableObject {

    @Published var user: User? = nil

    private var listener: ListenerRegistration?
    private var isListening = false
    private var userId: String?

    func startListening() {

        if isListening { return }
        isListening = true

        guard let uid = Auth.auth().currentUser?.uid else {
            print("❌ NO USER")
            return
        }

        self.userId = uid

        let db = Firestore.firestore()

        listener = db.collection("users")
            .document(uid)
            .addSnapshotListener { snapshot, error in

                if let error = error {
                    print("❌ ERROR:", error)
                    return
                }

                guard let data = snapshot?.data() else {
                    print("❌ NO DATA")
                    return
                }

                DispatchQueue.main.async {
                    self.user = User(
                        id: uid,
                        name: data["name"] as? String ?? "",
                        email: data["email"] as? String ?? "",
                        joined: data["joined"] as? TimeInterval ?? 0
                    )
                }
            }
    }

    func stopListening() {
        listener?.remove()
        listener = nil
        isListening = false
    }

    func logout() {
        do {
            try Auth.auth().signOut()
            stopListening()
        } catch {
            print(error)
        }
    }
}
