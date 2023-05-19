import SwiftUI

@main
struct FoodLogApp: App {
  let persistenceController = PersistenceController.shared

  var body: some Scene {
    WindowGroup {
      RootTabViews()
        .environment(\.managedObjectContext, persistenceController.container.viewContext)
      //                .task {
      //                    await PersistentDataStore.shared.start(observing: persistenceController.container.viewContext)
      //                }
    }
  }
}
