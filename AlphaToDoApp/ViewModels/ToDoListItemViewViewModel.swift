import FirebaseAuth
import FirebaseFirestore
import Foundation

class ToDoListItemViewViewModel: ObservableObject {

    init() {}

    func toggleIsDone(item: ToDoListItem) {

        var itemCopy = item
        itemCopy.setDone(!item.isDone)

        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }

        guard let id = itemCopy.id else {
            return
        }

        let db = Firestore.firestore()

        db.collection("users")
            .document(uid)
            .collection("todos")
            .document(id)
            .setData(itemCopy.asDictionary())
    }
}
