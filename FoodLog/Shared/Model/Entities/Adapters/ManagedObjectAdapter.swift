import Foundation
import CoreData

protocol ManagedObjectAdapterRepresentable: Adapter where Source: NSManagedObject {}

enum ManagedObjectAdapter {
    enum NutritionInfo: ManagedObjectAdapterRepresentable {
        static func value(mappedTo source: NutritionInfoMO) -> some NutritionInfoRepresentable { source.wrapped }
    }
    
    enum NutrientQuantity: ManagedObjectAdapterRepresentable {
        static func value(mappedTo source: NutrientQuantityMO) -> some DietaryQuantityRepresentable { source.wrapped }
    }
    
    enum ServingSize: ManagedObjectAdapterRepresentable {
        static func value(mappedTo source: ServingSizeMO) -> some DietaryQuantityRepresentable { source.wrapped }
    }
    
    enum SampleQuantity: ManagedObjectAdapterRepresentable {
        static func value(mappedTo source: SampleQuantityMO) -> some SampleQuantityRepresentable { source.wrapped }
    }
}


