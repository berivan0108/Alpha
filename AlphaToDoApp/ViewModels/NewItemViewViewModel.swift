import Foundation
import FirebaseFirestore
import FirebaseAuth

class NewItemViewViewModel: ObservableObject {

    @Published var title = ""
    @Published var dueDate = Date()
    @Published var showAlert = false

    init() {}

    func save() {

        guard canSave else {
            return
        }

        guard let uId = Auth.auth().currentUser?.uid else {
            print("NO USER")
            return
        }

        let newItemId = UUID().uuidString

        let db = Firestore.firestore()

        db.collection("users")
            .document(uId)
            .collection("todos")
            .document(newItemId)
            .setData([
                "id": newItemId,
                "title": title,
                "dueDate": dueDate.timeIntervalSince1970,
                "createDate": Date().timeIntervalSince1970,
                "isDone": false
            ])

        print("SAVED: \(newItemId)")
    }

    var canSave: Bool {

        guard !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return false
        }

        guard dueDate >= Date().addingTimeInterval(-86400) else {
            return false
        }

        return true
    }
}
