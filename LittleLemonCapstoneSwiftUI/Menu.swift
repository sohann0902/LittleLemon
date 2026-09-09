import SwiftUI
import CoreData

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var searchText = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            Text("Menu")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            FetchedObjects(
                predicate: buildPredicate(),
                sortDescriptors: buildSortDescriptors()
            ) { (dishes: [Dish]) in
                
                List {
                    ForEach(dishes) { dish in
                        HStack(spacing: 15) {
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text(dish.title ?? "")
                                    .font(.headline)
                                
                                Text("$\(dish.price ?? "")")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                            
                            AsyncImage(
                                url: URL(string: dish.image ?? "")
                            ) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                            } placeholder: {
                                Color.gray.opacity(0.2)
                            }
                            .frame(width: 80, height: 80)
                            .cornerRadius(10)
                        }
                        .padding(.vertical, 5)
                    }
                }
                .listStyle(.plain)
                .frame(minHeight: 400)
            }
        }
        .onAppear {
            getMenuData()
        }
    }
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [
            NSSortDescriptor(
                key: "title",
                ascending: true,
                selector: #selector(NSString.localizedStandardCompare)
            )
        ]
    }
    
    func buildPredicate() -> NSPredicate {
        if searchText.isEmpty {
            return NSPredicate(value: true)
        }
        
        return NSPredicate(
            format: "title CONTAINS[cd] %@",
            searchText
        )
    }
    
    func getMenuData() {
        PersistenceController.shared.clear()
        
        let urlString =
        "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/api/menu.json"
        
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, _, _ in
            if let data = data {
                let decoder = JSONDecoder()
                
                if let menuList = try? decoder.decode(
                    MenuList.self,
                    from: data
                ) {
                    DispatchQueue.main.async {
                        for menuItem in menuList.menu {
                            let dish = Dish(context: viewContext)
                            
                            dish.title = menuItem.title
                            dish.image = menuItem.image
                            dish.price = menuItem.price
                        }
                        
                        try? viewContext.save()
                    }
                }
            }
        }.resume()
    }
}

