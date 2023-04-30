import Foundation
import CoreData

struct Quantity: QuantityRepresentable {
    let identifier: QuantityIdentifier
    let id: UUID?
    var measurement: Measurement<Dimension>
    
    
    init(identifier: QuantityIdentifier, measurement: Measurement<Dimension>, id: UUID? = nil) {
        self.id = id
        self.identifier = identifier
        self.measurement = measurement
    }
}

struct NutritionInfo: NutritionInfoRepresentable {
    var servingSize: (any DietaryQuantityRepresentable)?
    var nutrientQuantities: [any DietaryQuantityRepresentable]
    
    init(servingSize: any DietaryQuantityRepresentable, nutrientQuantities: [any DietaryQuantityRepresentable]) {
        self.servingSize = servingSize
        self.nutrientQuantities = nutrientQuantities
    }
}

/// NutrientQuantityRepresentable
struct DietaryQuantity: DietaryQuantityRepresentable, ImplementationWrapper {
    
    // MARK: Nutrient Quantity Representable
    var nutritionInfo: (any NutritionInfoRepresentable)?

    // MARK: Implementation Wrapper
    let wrapped: Quantity

    // MARK: Initilizer
    init(quantity: Quantity, nutritionInfo: (any NutritionInfoRepresentable)? = nil) {
        self.nutritionInfo = nutritionInfo
        self.wrapped = quantity
    }
}

// SampleQuantityRepresentable
struct SampleQuantity: SampleQuantityRepresentable, ImplementationWrapper, Equatable, Hashable {
    // MARK: Sample Quantity Representable
    let date: Date
    
    // MARK: Implementation Wrapper
    let wrapped: Quantity
    
    // MARK: Initializer
    init(quantity: Quantity, date: Date) {
        self.wrapped = quantity
        self.date = date
    }
    
    static func == (_ lhs: SampleQuantity, _ rhs: SampleQuantity) -> Bool {
        lhs.id == rhs.id &&
        lhs.identifier == rhs.identifier &&
        lhs.measurement == rhs.measurement &&
        lhs.date == rhs.date
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(identifier)
        hasher.combine(measurement)
        hasher.combine(date)
    }
}




/*
 
 
 public protocol IdentifiableMeasurement: Identifiable {
     associatedtype UnitType: Dimension
     
     var id: UUID? { get }
     var identifier: QuantityIdentifier { get }
     var measurement: Measurement<UnitType> { get }
     
     init(identifier: QuantityIdentifier, measurement: Measurement<UnitType>)
     
     init(identifier: QuantityIdentifier, measurement: Measurement<UnitType>, existingID: UUID?)
 }

 extension IdentifiableMeasurement {
     init(identifier: QuantityIdentifier, measurement: Measurement<UnitType>) {
         self.init(identifier: identifier, measurement: measurement, existingID: .init())
     }
 }

 struct IdentifiedMeasurement<UnitType: Dimension>: IdentifiableMeasurement {
     let id: UUID?
     let identifier: QuantityIdentifier
     var measurement: Measurement<UnitType>
     
     init(identifier: QuantityIdentifier, measurement: Measurement<UnitType>, existingID: UUID?) {
         self.id = existingID
         self.identifier = identifier
         self.measurement = measurement
     }
 }

 */
