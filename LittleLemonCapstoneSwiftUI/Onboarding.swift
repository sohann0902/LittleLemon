import SwiftUI

struct Onboarding: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var showHome = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {

                Spacer()

                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)

                Text("Welcome to Little Lemon")
                    .font(.system(size: 30, weight: .bold))
                    .multilineTextAlignment(.center)

                Text("REGISTER")
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)

                VStack(alignment: .leading, spacing: 6) {

                    Text("First Name*")
                        .font(.headline)

                    TextField("", text: $firstName)
                        .textFieldStyle(.roundedBorder)

                    Text("Last Name*")
                        .font(.headline)
                        .padding(.top, 6)

                    TextField("", text: $lastName)
                        .textFieldStyle(.roundedBorder)

                    Text("Email*")
                        .font(.headline)
                        .padding(.top, 6)

                    TextField("", text: $email)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.emailAddress)
                }
                .padding(.horizontal, 30)

                Spacer()

                Button("Register") {
                    registerUser()
                }
                .buttonStyle(.borderedProminent)
                .tint(Color.green)

                Spacer()
                    .frame(height: 20)
            }
            .padding()
            .navigationDestination(isPresented: $showHome) {
                Home()
            }
        }
    }

    private func registerUser() {
        guard !firstName.isEmpty,
              !lastName.isEmpty,
              !email.isEmpty else {
            return
        }

        UserDefaults.standard.set(firstName, forKey: "firstName")
        UserDefaults.standard.set(lastName, forKey: "lastName")
        UserDefaults.standard.set(email, forKey: "email")
        UserDefaults.standard.set(true, forKey: "isLoggedIn")

        showHome = true
    }
}

