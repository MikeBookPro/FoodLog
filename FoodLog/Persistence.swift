//

import CoreData

struct QuantityTypeBuilder {
    let context: NSManagedObjectContext
    
    func weight(sampleFrom sample: some SampledMeasurement) {
        let sampleMO = BodyQuantitySampleMO(context: context)
        sampleMO.startDate = sample.dateRange.start
        sampleMO.endDate = sample.dateRange.end
        
        sampleMO.measurementValue = sample.measurement.value
        sampleMO.measurementUnit = DimensionUnitInterpreter.baseUnit(for: sample)
        
        let identifierMO = BodyMeasurementIdentifierMO(context: context)
        identifierMO.id = sample.id
        sampleMO.identifier = identifierMO
    }
    
    func weightMeasurement(from sample: some IdentifiableMeasurement) {
        let weightSample = BodyQuantitySampleMO(context: context)
        weightSample.startDate = .now
        weightSample.endDate = .now
        
        let identifier = BodyMeasurementIdentifierMO(context: context)
        identifier.id = sample.id
        weightSample.identifier = identifier
    }
}

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        let builder = QuantityTypeBuilder(context: viewContext)
        for sample in SampleWeightMeasurements.samples {
            builder.weightMeasurement(from: sample)
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        // Register the transformer
        ValueTransformer.setValueTransformer(MeasurementTransformer(), forName: MeasurementTransformer.name)
        
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
