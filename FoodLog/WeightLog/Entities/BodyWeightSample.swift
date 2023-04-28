import Foundation

#if DEBUG

struct SampleWeightMeasurements {
    private static let quantities: [Quantity] = [
        .init(identifier: .bodyMass, measurement: .init(value: .random(in: 120...145), unit: UnitMass.kilograms)),
        .init(identifier: .bodyMass, measurement: .init(value: .random(in: 120...145), unit: UnitMass.kilograms)),
        .init(identifier: .bodyMass, measurement: .init(value: .random(in: 120...145), unit: UnitMass.kilograms)),
        .init(identifier: .bodyMass, measurement: .init(value: .random(in: 120...145), unit: UnitMass.kilograms)),
    ]
    
    
    static let samples: [SampleQuantity] = quantities.map { .init(quantity: $0, date: .now) }
}

#endif



