import Foundation
import FirebaseFirestore
struct ToDoListItem: Codable, Identifiable {

    @DocumentID var id: String?   // 🔥 Firebase için doğru kullanım

    let title: String
    let dueDate: TimeInterval
    let createDate: TimeInterval
    var isDone: Bool

    mutating func setDone(_ state: Bool) {
        isDone = state
    }
}
