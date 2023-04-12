import Foundation

struct BodyWeightSample: SampledMeasurement {
    typealias UnitType = UnitMass
    typealias IdentifiedMeasure = IdentifiedMeasurement<UnitType>
    
    var identifier: QuantityIdentifier
    var measurement: Measurement<UnitMass>
    var dateRange: DateRange
    
    init(quantity: IdentifiedMeasurement<UnitType>, dateRange: DateRange) {
        self.identifier = quantity.identifier
        self.measurement = quantity.measurement
        self.dateRange = dateRange
    }
    
    init(identifier: QuantityIdentifier, measurement: Measurement<UnitMass>) {
        self.init(quantity: .init(identifier: identifier, measurement: measurement), dateRange: (nil, nil))
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
