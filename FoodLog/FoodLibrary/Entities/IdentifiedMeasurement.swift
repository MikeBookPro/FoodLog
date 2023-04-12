import Foundation

// MARK: - Identifiable Measurement

public protocol IdentifiableMeasurement: Identifiable where ID == String {
    associatedtype Identifier: QuantityIdentifier where Identifier.ID == Self.ID
    associatedtype UnitType: Dimension
    
    var id: ID { get }
    var identifier: Identifier { get }
    var measurement: Measurement<UnitType> { get }
}

public extension IdentifiableMeasurement {
    var id: ID { self.identifier.id }
}

public protocol IdentifiableMeasurementInitializable: IdentifiableMeasurement {
    init(identifier: Identifier, measurement: Measurement<UnitType>)
}

struct IdentifiedMeasurement<Identifier: QuantityIdentifier, UnitType: Dimension>: IdentifiableMeasurementInitializable where Identifier.ID == String {
    let identifier: Identifier
    var measurement: Measurement<UnitType>
    
    init(identifier: Identifier, measurement: Measurement<UnitType>) {
        self.identifier = identifier
        self.measurement = measurement
    }
}

struct SampleWeightMeasurements {
    private static let weightSamples: [IdentifiedMeasurement<BodyMeasurementQuantityType, UnitMass>] = [
        .init(identifier: .bodyMass, measurement: .init(value: .random(in: 120...145), unit: .kilograms)),
        .init(identifier: .bodyMass, measurement: .init(value: .random(in: 120...145), unit: .kilograms)),
        .init(identifier: .bodyMass, measurement: .init(value: .random(in: 120...145), unit: .kilograms)),
        .init(identifier: .bodyMass, measurement: .init(value: .random(in: 120...145), unit: .kilograms)),
    ]
    
    
    static let samples: [some IdentifiableMeasurement] = weightSamples
}

