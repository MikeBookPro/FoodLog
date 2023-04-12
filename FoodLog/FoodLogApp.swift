//

import SwiftUI

@main
struct FoodLogApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
//            ContentView()
            WeightHistoryView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
