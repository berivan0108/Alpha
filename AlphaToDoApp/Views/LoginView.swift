import SwiftUI

struct LoginView: View {

    @StateObject var viewModel = LoginViewViewModel()

    var body: some View {
        NavigationStack {

            VStack {

                HeaderView()

                Form {

                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundStyle(.red)
                    }

                    TextField("Email Adresiniz", text: $viewModel.email)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)

                    SecureField("Şifreniz", text: $viewModel.password)
                }
                .frame(height: 160)

                BigButton(title: "Giriş Yap") {
                    viewModel.login()
                }

                Spacer()

                VStack {
                    Text("Buralarda yeni misin?")
                    NavigationLink("Yeni hesap oluştur!") {
                        RegisterView()
                    }
                }
            }
        }
    }
}
