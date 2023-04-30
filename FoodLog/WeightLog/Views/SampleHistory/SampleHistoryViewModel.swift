import Foundation
import Combine

class SampleHistoryViewModel: ObservableObject {
    @Published var samples = [SampleQuantity]()
    @Published var isShowingEditor: Bool = false
    @Published var selected: SampleQuantity?
    
    private var cancellable: AnyCancellable?
    private let dataStore: DataStore
    
    init(dataStore: DataStore) {
        self.dataStore = dataStore
        self.cancellable = dataStore.$sampleQuantities
            .sink { [weak self] newSampleQuantities in
                self?.samples = newSampleQuantities.values.sorted { $0.date < $1.date }
            }
        
    }
    
    deinit { cancellable?.cancel() }
    
    func refresh() {
        Task {
            await dataStore.refresh()
        }
    }
    
    func presentEditor() {
        self.isShowingEditor = true
    }
    
    func dismissEditor() {
        self.isShowingEditor = false
    }
    
    func create(sample quantity: SampleQuantity) {
        let dataStore = self.dataStore
        Task { await dataStore.create(sampleQuantity: quantity) }
        dismissEditor()
    }
    
    func update(sample quantity: SampleQuantity) {
        let dataStore = self.dataStore
        Task { await dataStore.update(sampleQuantity: quantity) }
        dismissEditor()
    }
    
    func delete(samplesAt offsets: IndexSet) {
        let targetedIDs: [UUID] = offsets.compactMap { samples[$0].id }
        let dataStore = self.dataStore
        Task {
            await withTaskGroup(of: Void.self) { taskGroup in
                for id in targetedIDs {
                    taskGroup.addTask {
                        await dataStore.delete(sampleQuantityWithID: id)
                    }
                }
            }
        }
    }
}
