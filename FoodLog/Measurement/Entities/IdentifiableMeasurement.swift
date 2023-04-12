import Foundation

// MARK: - Identifiable Measurement

public protocol IdentifiableMeasurement: Identifiable {
    associatedtype UnitType: Dimension
    
    var id: QuantityIdentifier.ID { get }
    var identifier: QuantityIdentifier { get }
    var measurement: Measurement<UnitType> { get }
    
    init(identifier: QuantityIdentifier, measurement: Measurement<UnitType>)
}

public extension IdentifiableMeasurement {
    var id: QuantityIdentifier.ID { self.identifier.id }
}

struct IdentifiedMeasurement<UnitType: Dimension>: IdentifiableMeasurement {
    let identifier: QuantityIdentifier
    var measurement: Measurement<UnitType>
    
    init(identifier: QuantityIdentifier, measurement: Measurement<UnitType>) {
        self.identifier = identifier
        self.measurement = measurement
    }
}



