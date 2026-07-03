import SwiftUI

struct NewItemView: View {

    @Binding var newItemPresented: Bool
    @StateObject private var viewModel = NewItemViewViewModel()

    var body: some View {

        Form {

            Text("Yeni Görev")
                .font(.title)
                .bold()

            TextField("Başlık", text: $viewModel.title)

            DatePicker("Bitiş Tarihi", selection: $viewModel.dueDate)
                .datePickerStyle(.graphical)

            BigButton(title: "Kaydet") {

                if viewModel.canSave {
                    viewModel.save()
                    newItemPresented = false
                } else {
                    viewModel.showAlert = true
                }
            }
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(
                title: Text("Hata"),
                message: Text("Lütfen verilerin doğruluğunu kontrol edin")
            )
        }
    }
}
