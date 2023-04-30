//

import SwiftUI

@main
struct FoodLogApp: App {
    @State private var selectedTab = 1
    let persistenceController = PersistenceController.shared
    

    var body: some Scene {
        WindowGroup {

            TabView(selection: $selectedTab) {
                Text("First View")
                    .tabItem {
                        Image(systemName: "figure.martial.arts")
                        Text("Activity")
                    }
                    .tag(0)
                
                SampleHistoryView()
                    .tabItem {
                        Image(systemName: "chart.line.uptrend.xyaxis")
                        Text("Progress")
                    }
                    .tag(1)
                
                Text("Third View")
                    .tabItem {
                        Image(systemName: "carrot")
                        Text("Nutrition")
                    }
                    .tag(2)
            }
            .environment(\.managedObjectContext, persistenceController.container.viewContext)

            
                
        }
    }
}
