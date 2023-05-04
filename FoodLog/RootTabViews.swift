import SwiftUI
import CoreData

struct RootTabViews: View {
        @Environment(\.managedObjectContext) private var moc
        @State private var selectedTab = 1
    @FetchRequest(sortDescriptors: [], animation: .default)
    private var samples: FetchedResults<SampleQuantityMO>
    
    private static func adapt(quantity samples: FetchedResults<SampleQuantityMO>) -> [SampleQuantity] {
        return samples.map { SampleQuantity.copy(from: ManagedObjectAdapter.SampleQuantity.value(mappedTo: $0)) }
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Text("First View")
                .tabItem {
                    Image(systemName: "figure.martial.arts")
                    Text("Activity")
                }
                .tag(0)
            
            ProgessList(samples: Self.adapt(quantity: samples))
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
    }
}

struct RootTabViews_Previews: PreviewProvider {
    static var previews: some View {
        RootTabViews()
    }
}
