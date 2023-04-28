import Foundation
import CoreData

protocol ImplementationWrapper {
    associatedtype Wrapped
    var wrapped: Wrapped { get }
}

extension ImplementationWrapper where Self: QuantityRepresentable, Wrapped: QuantityRepresentable {
    var identifier: QuantityIdentifier { wrapped[keyPath: \.identifier] }
    
    var id: UUID? { wrapped[keyPath: \.id] }
    
    var measurement: Measurement<Dimension> { wrapped[keyPath: \.measurement] }
}

extension ImplementationWrapper where Self: SampleQuantityRepresentable, Wrapped: SampleQuantityRepresentable {
    var date: Date { wrapped[keyPath: \.date] }
}

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

/// For both NutrientQuantity and ServingSize
struct DietaryQuantity: NutrientQuantityRepresentable, ImplementationWrapper {
    // MARK: Nutrient Quantity Representable
    var nutrutionInfo: NutritionInfoRepresentable?
    
    // MARK: Implementation Wrapper
    let wrapped: Quantity
    
    // MARK: Initilizer
    init(quantity: Quantity, nutrutionInfo: NutritionInfoRepresentable? = nil) {
        self.nutrutionInfo = nutrutionInfo
        self.wrapped = quantity
    }
}

// SampleQuantityRepresentable
struct Sample: SampleQuantityRepresentable, ImplementationWrapper {
    // MARK: Sample Quantity Representable
    let date: Date
    
    // MARK: Implementation Wrapper
    let wrapped: Quantity
    
    // MARK: Initializer
    init(quantity: Quantity, date: Date) {
        self.wrapped = quantity
        self.date = date
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
