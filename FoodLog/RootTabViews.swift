import SwiftUI
import CoreData

struct RootTabViews: View {
  @Environment(\.managedObjectContext) private var moc

  @State private var selectedTab = 0

//  @FetchRequest(sortDescriptors: [], animation: .default)
//  private var samples: FetchedResults<SampleQuantityMO>
//
//  private static func adapt(quantity samples: FetchedResults<SampleQuantityMO>) -> [SampleQuantity] {
//    return samples.map { SampleQuantity.copy(from: ManagedObjectAdapter.SampleQuantity.value(mappedTo: $0)) }
//  }

  var body: some View {
    TabView(selection: $selectedTab) {
//      Text("First View")
//        .tabItem {
//          Image(systemName: "figure.martial.arts")
//          Text("Activity")
//        }
//        .tag(0)
//
//      SummaryView(
//        list: Self.adapt(quantity: samples),
//        editorView: SampleQuantityForm.init(_:)
//      )
//      .tabItem {
//        Image(systemName: "chart.line.uptrend.xyaxis")
//        Text("Summary")
//      }
//      .tag(0)

      Text("Third View")
        .tabItem {
          Image(systemName: "carrot")
          Text("Nutrition")
        }
        .tag(0)
    }
  }
}

#if DEBUG
struct RootTabViews_Previews: PreviewProvider {
  static var previews: some View {
    RootTabViews()
    //            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
  }
}
#endif
