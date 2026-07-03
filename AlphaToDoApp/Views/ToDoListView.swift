import SwiftUI
import FirebaseFirestore

struct ToDoListView: View {
    
    let userId: String
    @StateObject var viewModel: ToDoListViewViewModel
    
    init(userId: String) {
        self.userId = userId
        self._viewModel = StateObject(
            wrappedValue: ToDoListViewViewModel(userId: userId)
        )
    }
    
    var body: some View {
        NavigationView {
            List(viewModel.items) { item in
                ToDoListItemView(item: item)
                    .swipeActions {
                        Button("Sil") {
                            guard let id = item.id else { return }
                            viewModel.delete(id: id)
                        }
                        .tint(.red)
                    }
            }
            .navigationTitle("Görevler")
            .toolbar {
                Button {
                    viewModel.showInNewItemView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $viewModel.showInNewItemView) {
                NewItemView(newItemPresented: $viewModel.showInNewItemView)
            }
        }
    }
}

#Preview {
    ToDoListView(userId: "jnVkmJ8RhySqQETyyOmNReI8vLe2")
}
