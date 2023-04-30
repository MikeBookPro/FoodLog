import Foundation
import SwiftUI
import Combine

/// This is used to create an @Environment
//struct PersistentDataStoreKey: EnvironmentKey {
//    static var defaultValue: PersistentDataStore = .shared
//}
//
//
//extension EnvironmentValues {
//    var dataStore: PersistentDataStore {
//        get { self[PersistentDataStoreKey.self] }
//        set { self[PersistentDataStoreKey.self] = newValue }
//    }
//}


final class DataStore: ObservableObject {
    @Published private(set) var sampleQuantities = [UUID: SampleQuantity]()
    
    init(sampleQuantities: [UUID: SampleQuantity] = [:]) {
        Task {
            for sample in sampleQuantities.values {
                await withTaskGroup(of: Void.self) { taskGroup in
                    taskGroup.addTask {
                        await PersistentDataStore.shared.create(sampleQuantity: sample)
                    }
                }
                let updatedQuantities = await PersistentDataStore.shared.sampleQuantities
                DispatchQueue.main.async {
                    self.sampleQuantities = updatedQuantities
                }
            }
            
        }
    }
    
    func create(sampleQuantity: SampleQuantity) async {
        // TODO: Update in CoreData
        await PersistentDataStore.shared.create(sampleQuantity: sampleQuantity)
        let updatedSamples = await PersistentDataStore.shared.sampleQuantities
        DispatchQueue.main.async { [weak self] in
            self?.sampleQuantities = updatedSamples
        }
    }
    
    func update(sampleQuantity: SampleQuantity) async {
        // TODO: Update in CoreData
        await PersistentDataStore.shared.update(sampleQuantity: sampleQuantity)
        let updatedSamples = await PersistentDataStore.shared.sampleQuantities
        DispatchQueue.main.async { [weak self] in
            self?.sampleQuantities = updatedSamples
        }
    }
    
    func delete(sampleQuantityWithID id: UUID?) async {
        // TODO: Update in CoreData
        guard let id else { return }
        await PersistentDataStore.shared.delete(sampleQuantityWithID: id)
        let updatedSamples = await PersistentDataStore.shared.sampleQuantities
        DispatchQueue.main.async { [weak self] in
            self?.sampleQuantities = updatedSamples
        }
    }
}


actor PersistentDataStore {

    public static let shared: PersistentDataStore = .init()
    
    private init() {}
    
    private(set) var sampleQuantities = [UUID: SampleQuantity]()
    
    func create(sampleQuantity: SampleQuantity) {
        // TODO: Update in CoreData
        sampleQuantities[sampleQuantity.id ?? .init()] = sampleQuantity
    }
    
    func update(sampleQuantity: SampleQuantity) {
        // TODO: Update in CoreData
        if let existingID = sampleQuantity.id {
            sampleQuantities[existingID] = sampleQuantity
        }
    }
    
    func delete(sampleQuantityWithID id: UUID?) {
        // TODO: Update in CoreData
        guard let id else { return }
        sampleQuantities[id] = nil
    }
}

