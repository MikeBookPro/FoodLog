import SwiftUI
import CoreData

//protocol AdaptableContent {
//    associatedtype PersistentModel: NSManagedObject
//    associatedtype Adapter: MappedAdapter where Adapter.Source == PersistentModel
//}

struct PersistedContentList<Content: View>: View {
    private let nestedView: PersistentContentView.NestedView<Content>

    init(@ViewBuilder content: @escaping ([String]) -> Content) {
        self.nestedView = PersistentContentView.NestedView { fetchedItems in
            content(fetchedItems)
        }
    }

    var body: some View {
        nestedView
#if DEBUG
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
#else
            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
#endif
    }

}

extension PersistedContentList {

    struct NestedView<Content: View>: View {
        @Environment(\.managedObjectContext) private var moc

        // TODO: Replace this with generic Managed object to use for all
        @FetchRequest(
            sortDescriptors: [NSSortDescriptor(keyPath: \SampleQuantityMO.date, ascending: true)],
            animation: .default
        ) private var profiles: FetchedResults<SampleQuantityMO>

        private let content: ([String]) -> Content

        init(@ViewBuilder content: @escaping ([String]) -> Content) {
            self.content = content
        }

        var body: some View {
            content(profiles.compactMap { $0.date?.formatted(date: .abbreviated, time: .shortened) })
        }


        // MARK: - Private Helpers
    }
}


#if DEBUG
//struct PersistedContentList_Previews: PreviewProvider {
//    static var previews: some View {
//        PersistedContentList { items in
//            List {
//                ForEach(items, id: \.hash) {
//                    Text($0)
//                }
//            }
//        }
//        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
#endif
