//

import CoreData

struct DataManager {
    let context: NSManagedObjectContext
    
    // MARK: - Fetch
    
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
    
    // MARK: - Create
    
    @discardableResult
    func create<Sample>(sample model: some SampleQuantityRepresentable) async -> Sample where Sample: SampleQuantityMO {
        let sampleMO = Sample(context: context)
        sampleMO.measurementID = model.id ?? UUID()
        let result = await update(sample: sampleMO, with: model, shouldSave: true)
        print(result)
        return sampleMO
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

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
//        let builder = QuantityTypeBuilder(context: viewContext)
//        for sample in SampleWeightMeasurements.samples {
//            builder.weightMeasurement(from: sample)
//        }
//        do {
//            try viewContext.save()
//        } catch {
//            // Replace this implementation with code to handle the error appropriately.
//            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//            let nsError = error as NSError
//            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "FoodLog")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
