import SwiftUI

@main
struct LittleLemonCapstoneSwiftUIApp: App {
    @AppStorage("isLoggedIn") private var isLoggedIn = false

    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                Home()
            } else {
                Onboarding()
            }
        }
    }
}

