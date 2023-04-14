import Foundation
import CoreData

struct BodyWeightSample: SampledMeasurement, Identifiable {
    typealias UnitType = UnitMass
    typealias IdentifiedMeasure = IdentifiedMeasurement<UnitType>
    
    let id: UUID?
    var identifier: QuantityIdentifier
    var measurement: Measurement<UnitMass>
    var date: Date
    
    init(quantity: IdentifiedMeasurement<UnitType>, date: Date) {
        self.id = quantity.id
        self.identifier = quantity.identifier
        self.measurement = quantity.measurement
        self.date = date
    }
    
    init(identifier: QuantityIdentifier, measurement: Measurement<UnitMass>, existingID: UUID? = nil) {
        self.init(
            quantity: .init(
                identifier: identifier,
                measurement: measurement,
                existingID: existingID ?? UUID()
            ),
            date: .now
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
//
//extension IdentifiedMeasurementMO {
//    var measurement: Measurement<Dimension>? {
//        guard let dimension = DimensionIdentifier(baseUnitSymbol: self.measurementUnit) else { return nil }
//        return MeasurementFactory.measurement(forDimension: dimension, value: self.measurementValue)
//    }
//}

protocol PropertyAdapter {
    associatedtype Input
    associatedtype Output
    associatedtype Value
    
    var paths: (read: KeyPath<Input, Value>, write: WritableKeyPath<Output, Value>) { get }
    
    init(read: KeyPath<Input, Value>, write: WritableKeyPath<Output, Value>)
    
    func adapt(_ input: Input, into output: Output) -> Output
}

extension PropertyAdapter {
    func adapt(_ input: Input, into output: Output) -> Output {
        var copy = output
        copy[keyPath: paths.write] = input[keyPath: paths.read]
        return copy
    }
}



struct UUIDPropertyAdapter<Input, Output>: PropertyAdapter {
    typealias Value = UUID?
    var paths: (read: KeyPath<Input, Value>, write: WritableKeyPath<Output, Value>)
    
    init(read: KeyPath<Input, Value>, write: WritableKeyPath<Output, Value>) {
        self.paths = (read, write)
    }
}

//struct StingPropertyAdapter<Input, Output>: PropertyAdapter {
//    typealias Value = String
//
//    var paths: (read: KeyPath<Input, String?>, write: WritableKeyPath<Output, String?>)
//
//    init(read: KeyPath<Input, String?>, write: WritableKeyPath<Output, String?>) {
//        self.paths = (read, write)
//    }
//}
//protocol DoublePropertyAdapter: PropertyAdapter where T == Double {}
//protocol UUIDPropertyAdapter: PropertyAdapter where T == UUID {}




//BodyQuantitySampleMO
//struct WeightSamplePropertyAdapter<T>: PropertyAdapter {
//    typealias Input = BodyQuantitySampleMO
//    typealias Output = BodyWeightSample
//
//    var paths: (read: KeyPath<BodyQuantitySampleMO, T>, write: WritableKeyPath<BodyWeightSample, T>)
//
//    init(read: KeyPath<BodyQuantitySampleMO, T>, write: WritableKeyPath<BodyWeightSample, T>) {
//        self.paths = (read, write)
//    }
//}

struct WeightSampleAdapter {
    typealias Input = SampleQuantityMO
    typealias Output = BodyWeightSample
    
    typealias UUIDAdapter = UUIDPropertyAdapter<Input, Output>
    
//    var propertyAdapters: [any PropertyAdapter] = [
//        UUIDPropertyAdapter<SampleQuantityMO, BodyWeightSample>(read: \.measurementID, write: \.id),
//
//    ]
}



struct BodyWeightSampleAdapter {

    static func adapt(sampleQuantity mo: BodyQuantitySampleMO) -> BodyWeightSample {
        let quantityIdentifier: QuantityIdentifier = .bodyMass
        let unit: UnitMass = (mo.measurementUnit != nil) ? .init(symbol: mo.measurementUnit!) : DimensionPreference<UnitMass>(wrappedValue: quantityIdentifier).projectedValue
        return BodyWeightSample(
            quantity: .init(
                identifier: quantityIdentifier,
                measurement: .init(value: mo.measurementValue, unit: unit),
                existingID: mo.measurementID
            ),
            date: mo.date ?? .now
        )
    }
    
}
