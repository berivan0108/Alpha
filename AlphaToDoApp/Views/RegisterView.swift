import SwiftUI

struct RegisterView: View {

    @StateObject private var viewModel = RegisterViewViewModel()

    var body: some View {
        NavigationStack {
            VStack {

                // Header
                HeaderView()

                // Register Formu
                Form {
                    Section("Kayıt Formu") {

                        TextField("Tam Adınız", text: $viewModel.name)
                            .autocorrectionDisabled()

                        TextField("Email adresiniz", text: $viewModel.email)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)

                        SecureField("Şifreniz", text: $viewModel.password)
                    }
                }
                .frame(height: 200)

                BigButton(title: "Hesap Oluştur") {
                    viewModel.register()
                }

                Spacer()
            }
        }
    }
}

#Preview {
    RegisterView()
}
