import SwiftUI

struct Profile: View {
    @AppStorage("isLoggedIn") private var isLoggedIn = true

    @State private var firstName =
        UserDefaults.standard.string(forKey: "firstName") ?? ""

    @State private var lastName =
        UserDefaults.standard.string(forKey: "lastName") ?? ""

    @State private var email =
        UserDefaults.standard.string(forKey: "email") ?? ""

    var body: some View {
        Form {
            Section {
                HStack {
                    Spacer()

                    Image("Profile")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 90, height: 90)

                    Spacer()
                }
                .padding(.vertical, 10)
            }

            Section("Personal Information") {
                VStack(alignment: .leading, spacing: 6) {
                    Text("First Name*")
                        .font(.headline)

                    TextField("", text: $firstName)
                        .textFieldStyle(.roundedBorder)
                }

                VStack(alignment: .leading, spacing: 6) {
                    Text("Last Name*")
                        .font(.headline)

                    TextField("", text: $lastName)
                        .textFieldStyle(.roundedBorder)
                }

                VStack(alignment: .leading, spacing: 6) {
                    Text("Email*")
                        .font(.headline)

                    TextField("", text: $email)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.emailAddress)
                }
            }

            Section {
                Button("Save Changes") {
                    UserDefaults.standard.set(firstName, forKey: "firstName")
                    UserDefaults.standard.set(lastName, forKey: "lastName")
                    UserDefaults.standard.set(email, forKey: "email")
                }

                Button("Log Out", role: .destructive) {
                    UserDefaults.standard.removeObject(forKey: "firstName")
                    UserDefaults.standard.removeObject(forKey: "lastName")
                    UserDefaults.standard.removeObject(forKey: "email")

                    isLoggedIn = false
                }
            }
        }
        .navigationTitle("Profile")
    }
}

