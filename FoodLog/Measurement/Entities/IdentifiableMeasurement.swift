import Foundation

// MARK: - Identifiable Measurement

public protocol IdentifiableMeasurement: Identifiable {
    associatedtype UnitType: Dimension
    
    var id: UUID { get }
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
    let id: UUID
    let identifier: QuantityIdentifier
    var measurement: Measurement<UnitType>
    
    init(identifier: QuantityIdentifier, measurement: Measurement<UnitType>, existingID: UUID?) {
        self.id = existingID ?? UUID()
        self.identifier = identifier
        self.measurement = measurement
    }
}



