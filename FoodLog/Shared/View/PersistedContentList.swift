import SwiftUI
import CoreData

struct SampleQuantitiesView<Content: View>: View {
    private let content: ([any SampleQuantityRepresentable]) -> Content

    init(@ViewBuilder content: @escaping ([any SampleQuantityRepresentable]) -> Content) {
        self.content = content
    }
    
    var body: some View {
        PersistedContent<Content, SampleQuantityMO> { fetchedResults in
            content(fetchedResults.compactMap(ManagedObjectAdapter.SampleQuantity.value(mappedTo:)))
        }
    }
}

struct PersistedContent<Content: View, ManagedObject: NSManagedObject>: View {
    @Environment(\.managedObjectContext) private var moc

    // TODO: Replace this with generic Managed object to use for all
    @FetchRequest(sortDescriptors: [], animation: .default)
    private var results: FetchedResults<ManagedObject>
    
    private let content: ([ManagedObject]) -> Content

    init(@ViewBuilder content: @escaping ([ManagedObject]) -> Content) {
        self.content = content
    }

    var body: some View {
        content(Array(results))
    }
}


#if DEBUG
struct SampleQuantitiesView_Previews: PreviewProvider {
    static var previews: some View {
        SampleQuantitiesView { samples in
            List(samples, id: \.id) { sample in
                Text(sample.date, format: Date.FormatStyle.init(date: .numeric, time: .shortened))
            }
        }
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
#endif
