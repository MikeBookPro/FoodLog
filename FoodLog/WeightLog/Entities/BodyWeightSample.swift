import Foundation

struct BodyWeightSample: SampledMeasurement {
    typealias UnitType = UnitMass
    typealias IdentifiedMeasure = IdentifiedMeasurement<UnitType>
    
    let id: UUID
    var identifier: QuantityIdentifier
    var measurement: Measurement<UnitMass>
    var dateRange: DateRange
    
    init(quantity: IdentifiedMeasurement<UnitType>, dateRange: DateRange) {
        self.id = quantity.id
        self.identifier = quantity.identifier
        self.measurement = quantity.measurement
        self.dateRange = dateRange
    }
    
    init(identifier: QuantityIdentifier, measurement: Measurement<UnitMass>, existingID: UUID? = nil) {
        self.init(
            quantity: .init(
                identifier: identifier,
                measurement: measurement,
                existingID: existingID ?? UUID()
            ),
            dateRange: (nil, nil)
        )
    }
    
}

#if DEBUG

struct SampleWeightMeasurements {
    private static let weightSamples: [IdentifiedMeasurement<UnitMass>] = [
        .init(identifier: .bodyMass, measurement: .init(value: .random(in: 120...145), unit: .kilograms)),
        .init(identifier: .bodyMass, measurement: .init(value: .random(in: 120...145), unit: .kilograms)),
        .init(identifier: .bodyMass, measurement: .init(value: .random(in: 120...145), unit: .kilograms)),
        .init(identifier: .bodyMass, measurement: .init(value: .random(in: 120...145), unit: .kilograms)),
    ]
    
    
    static let samples: [some IdentifiableMeasurement] = weightSamples
}

#endif
