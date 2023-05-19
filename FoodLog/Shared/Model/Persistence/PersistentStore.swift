// import Foundation
// import SwiftUI
// import Combine
// import CoreData
//
//
// final class DataStore: ObservableObject {
//    @Published private(set) var sampleQuantities = [UUID: SampleQuantity]()
//    
//    init(sampleQuantities: [UUID: SampleQuantity] = [:]) {
//        self.sampleQuantities = sampleQuantities
//    }
//    
//    func refresh() async  {
//        await PersistentDataStore.shared.load()
//        let updatedSamples = await PersistentDataStore.shared.sampleQuantities
//        DispatchQueue.main.async { [weak self] in
//            self?.sampleQuantities = updatedSamples
//        }
//    }
//    
//    func create(sampleQuantity: SampleQuantity) async {
//        // TODO: Update in CoreData
//        await PersistentDataStore.shared.create(sampleQuantity: sampleQuantity)
//        let updatedSamples = await PersistentDataStore.shared.sampleQuantities
//        DispatchQueue.main.async { [weak self] in
//            self?.sampleQuantities = updatedSamples
//        }
//    }
//    
//    func update(sampleQuantity: SampleQuantity) async {
//        // TODO: Update in CoreData
//        await PersistentDataStore.shared.update(sampleQuantity: sampleQuantity)
//        let updatedSamples = await PersistentDataStore.shared.sampleQuantities
//        DispatchQueue.main.async { [weak self] in
//            self?.sampleQuantities = updatedSamples
//        }
//    }
//    
//    func delete(sampleQuantityWithID id: UUID?) async {
//        // TODO: Update in CoreData
//        guard let id else { return }
//        await PersistentDataStore.shared.delete(sampleQuantityWithID: id)
//        let updatedSamples = await PersistentDataStore.shared.sampleQuantities
//        DispatchQueue.main.async { [weak self] in
//            self?.sampleQuantities = updatedSamples
//        }
//    }
// }
//
//
// actor PersistentDataStore {
//    public static let shared = PersistentDataStore()
//    
//    private(set) var sampleQuantities = [UUID: SampleQuantity]()
//    public private(set) var dataManager: DataManager!
//    
//    private init() {}
//    
//    func start(observing context: NSManagedObjectContext) {
//        self.dataManager = DataManager(context: context)
//    }
//    
//    func load() async {
//        let samples = await self.dataManager.fetchSampleQuantities()
//        self.sampleQuantities = samples.reduce(into: [UUID: SampleQuantity]()) { partialResult, sample in
//            partialResult[sample.id ?? .init()] = sample
//        }
//    }
//    
//    func create(sampleQuantity: SampleQuantity) async {
//        await dataManager.create(sample: sampleQuantity)
//        sampleQuantities[sampleQuantity.id ?? .init()] = sampleQuantity
//    }
//    
//    func update(sampleQuantity: SampleQuantity) async {
//        await dataManager.upsert(sample: sampleQuantity)
//        if let existingID = sampleQuantity.id {
//            sampleQuantities[existingID] = sampleQuantity
//        }
//    }
//    
//    func delete(sampleQuantityWithID id: UUID?) async {
//        guard let id else { return }
//        await dataManager.delete(sampleWithID: id, shouldSave: true)
//        sampleQuantities[id] = nil
//    }
// }
//
