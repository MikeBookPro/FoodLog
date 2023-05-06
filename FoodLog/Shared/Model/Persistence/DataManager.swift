import Foundation
import CoreData

struct DataManager {
    static var shared: DataManager!
    private let context: NSManagedObjectContext
    
    static func start(in context: NSManagedObjectContext) {
        guard shared == nil else { fatalError("Tried to start `DataManager.shared` more than once") }
        shared = .init(context: context)
    }
    
    // MARK: - Fetch
    
    public func fetchSampleQuantities() async -> [SampleQuantity] {
        let samples: [SampleQuantityMO]? = await context.perform {
            let fetchRequest: NSFetchRequest<SampleQuantityMO> = SampleQuantityMO.fetchRequest()
            return try? context.fetch(fetchRequest)
        }
        guard let samples else { return [] }
        return samples.map { SampleQuantity.copy(from: $0.wrapped) }
    }
    
    private func fetch(sample model: some SampleQuantityRepresentable) async -> SampleQuantityMO? {
        guard let measurementID = model.id else { return nil }
        let sample: SampleQuantityMO? = await context.perform {
            let fetchRequest: NSFetchRequest<SampleQuantityMO> = SampleQuantityMO.fetchRequest()
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = .init(format: "measurementID == %@", measurementID as CVarArg)
            return try? context.fetch(fetchRequest).first
        }
        return sample
    }
    
    private func fetch(sampleWithID id: UUID) async -> SampleQuantityMO? {
        let sample: SampleQuantityMO? = await context.perform {
            let fetchRequest: NSFetchRequest<SampleQuantityMO> = SampleQuantityMO.fetchRequest()
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = .init(format: "measurementID == %@", id as CVarArg)
            return try? context.fetch(fetchRequest).first
        }
        return sample
    }
    
    // MARK: - Create
    
    @discardableResult
    func create<Sample>(sample model: some SampleQuantityRepresentable) async -> Sample where Sample: SampleQuantityMO {
        let sampleMO = Sample(context: context)
        sampleMO.measurementID = model.id ?? UUID()
        return await update(sample: sampleMO, with: model, shouldSave: true)
    }
    
    // MARK: - Update
    
    private func update<Sample>(sample mo: Sample, with model: some SampleQuantityRepresentable, shouldSave: Bool = false) async -> Sample where Sample: SampleQuantityMO {
        mo.quantityIdentifier = model.identifier.rawValue
        mo.date = model.date
        mo.measurementUnit = model.measurement.unit.symbol
        mo.measurementValue = model.measurement.value
        if shouldSave {
            self.save()
        }
        return mo
    }
    
    // MARK: - Upsert (Create &/or Update)
    
    @discardableResult
    public func upsert<Sample>(sample model: some SampleQuantityRepresentable) async -> Sample where Sample: SampleQuantityMO {
        print("\(#file.split(separator: "/").last ?? "-"):\(#function): sample.id -> \(model.id?.uuidString ?? "-")")
        if let existing = await fetch(sample: model) as? Sample {
            return await update(sample: existing, with: model, shouldSave: true)
        }
        return await create(sample: model)
    }
    
    // MARK: - Delete
    @discardableResult
    public func delete(sample model: some SampleQuantityRepresentable, shouldSave: Bool = false) async -> Bool {
        guard let mo = await fetch(sample: model) else { return false }
        return await delete(managedObject: mo, shouldSave: shouldSave)
    }
    
    // MARK: - Delete
    @discardableResult
    public func delete(sampleWithID id: UUID, shouldSave: Bool = false) async -> Bool {
        guard let mo = await fetch(sampleWithID: id) else { return false }
        return await delete(managedObject: mo, shouldSave: shouldSave)
    }
    
    @discardableResult
    private func delete(managedObject: NSManagedObject, shouldSave: Bool = false) async -> Bool {
        await context.perform {
            context.delete(managedObject)
            if shouldSave {
                self.save()
            }
            return true
        }
    }
    
    
    // MARK: - Save
    
    func save() {
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }

}
