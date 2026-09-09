import SwiftUI
import CoreData

struct Home: View {
    let persistence = PersistenceController.shared

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {

                    //header
                    HStack {
                        Image("Logo")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 40)

                        Spacer()

                        NavigationLink(destination: Profile()) {
                            Image("Profile")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 42, height: 42)
                        }
                    }
                    .padding()
                    .background(Color.white)

                    //hero
                    VStack(spacing: 12) {

                        //text
                        HStack(alignment: .top, spacing: 15) {

                            VStack(alignment: .leading, spacing: 12) {
                                Text("Little Lemon")
                                    .font(.system(size: 38, weight: .bold))
                                    .foregroundColor(.yellow)

                                Text("Chicago")
                                    .font(.title2)
                                    .foregroundColor(.white)

                                Text("We are a family-owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                                    .foregroundColor(.white)
                            }
                            //hero image
                            Image("Hero image")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 130, height: 180)
                                .clipped()
                                .cornerRadius(16)
                                .offset(y: -5)
                        }

                        //search bar
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)

                            Text("Search menu")
                                .foregroundColor(.gray)

                            Spacer()
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        Color(
                            red: 0.29,
                            green: 0.37,
                            blue: 0.34
                        )
                    )

                    // MENU BREAKDOWN
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Order for Delivery")
                            .font(.title2)
                            .fontWeight(.bold)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                CategoryButton(title: "Starters")
                                CategoryButton(title: "Mains")
                                CategoryButton(title: "Desserts")
                                CategoryButton(title: "Sides")
                            }
                        }
                    }
                    .padding()
                    .background(Color.white)

                    //menu
                    Menu()
                        .environment(
                            \.managedObjectContext,
                            persistence.container.viewContext
                        )
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct CategoryButton: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.subheadline)
            .fontWeight(.bold)
            .padding(.horizontal, 18)
            .padding(.vertical, 10)
            .background(
                Color(
                    red: 0.95,
                    green: 0.91,
                    blue: 0.72
                )
            )
            .cornerRadius(20)
    }
}

