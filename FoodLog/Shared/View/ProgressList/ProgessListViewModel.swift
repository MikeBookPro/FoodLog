import Foundation
//import Combine

//class ProgessListViewModel: ObservableObject {
struct ProgessListViewModel {
    var isShowingEditor: Bool = false
    
    func create(sample quantity: SampleQuantity) {
        //let dataStore = self.dataStore
        Task {
            //await dataStore.create(sampleQuantity: quantity)
            await PersistentDataStore.shared.create(sampleQuantity: quantity)
        }
    }
    
    func update(sample quantity: SampleQuantity) {
        //let dataStore = self.dataStore
        Task {
            // await dataStore.update(sampleQuantity: quantity)
            await PersistentDataStore.shared.update(sampleQuantity: quantity)
            
        }
    }
    
    func delete(_ samples: [SampleQuantity], at offsets: IndexSet) {
        let targetedIDs: [UUID] = offsets.compactMap { samples[$0].id }
        Task {
            await withTaskGroup(of: Void.self) { taskGroup in
                for id in targetedIDs {
                    taskGroup.addTask {
                        // await dataStore.delete(sampleQuantityWithID: id)
                        await PersistentDataStore.shared.delete(sampleQuantityWithID: id)
                    }
                }
            }
        }
    }
}
