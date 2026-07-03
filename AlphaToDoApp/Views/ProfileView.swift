import SwiftUI

struct ProfileView: View {
    
    @StateObject var viewModel = ProfilViewViewModel()
    
    init() {}

    var body: some View {
        NavigationView {
            VStack {

                if let user = viewModel.user {

                    Image(systemName: "person.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundStyle(Color.blue)
                        .frame(width: 125, height: 125)

                    VStack {

                        HStack {
                            Text("İsim:")
                            Text(user.name)
                        }

                        HStack {
                            Text("Email:")
                            Text(user.email)
                        }

                        HStack {
                            Text("Kayıt tarihi:")
                            Text(
                                Date(timeIntervalSince1970: user.joined)
                                    .formatted(date: .abbreviated, time: .shortened)
                            )
                        }
                    }

                    // Logout işlemi
                    BigButton(title: "Çıkış Yap") {
                        viewModel.logout()
                    }

                } else {
                    Text("Profil yükleniyor...")
                }
            }
            .navigationTitle("Profil")
        }
        .onAppear {
            viewModel.startListening()
        }
        .onDisappear {
            viewModel.stopListening()
        }
    }
}

#Preview {
    ProfileView()
}
