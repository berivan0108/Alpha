import FirebaseFirestore
import Foundation

class ToDoListViewViewModel: ObservableObject {

    @Published var showInNewItemView = false
    @Published var items: [ToDoListItem] = []

    private let userId: String

    init(userId: String) {
        self.userId = userId
        fetchItems()   // 🔥 BURASI KRİTİK
    }

    // 🔥 FIRESTORE'DAN LİSTEYİ ÇEK
    func fetchItems() {

        let db = Firestore.firestore()

        db.collection("users")
            .document(userId)
            .collection("todos")
            .addSnapshotListener { snapshot, error in

                guard let documents = snapshot?.documents else {
                    return
                }

                self.items = documents.compactMap { doc in
                    try? doc.data(as: ToDoListItem.self)
                }
            }
    }

    // 🗑 DELETE
    func delete(id: String) {

        let db = Firestore.firestore()

        db.collection("users")
            .document(userId)
            .collection("todos")
            .document(id)
            .delete()
    }
}
