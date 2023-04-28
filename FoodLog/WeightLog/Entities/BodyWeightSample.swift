import Foundation
import CoreData

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


struct WeightSampleAdapter {
    typealias Input = SampleQuantityMO
    typealias Output = Sample
    
    typealias UUIDAdapter = UUIDPropertyAdapter<Input, Output>
    
//    var propertyAdapters: [any PropertyAdapter] = [
//        UUIDPropertyAdapter<SampleQuantityMO, BodyWeightSample>(read: \.measurementID, write: \.id),
//
//    ]
}



struct BodyWeightSampleAdapter {

    static func adapt(sampleQuantity mo: SampleQuantityMO) -> Sample {
        let quantityIdentifier: QuantityIdentifier = .init(string: mo.quantityIdentifier)
        return Sample(
            quantity: .init(
                identifier: .init(string: mo.quantityIdentifier),
                measurement: .init(
                    value: mo.measurementValue,
                    unit: IdentifierToDimensionAdapter.value(mappedTo: quantityIdentifier)
                ),
                id: mo.measurementID
            ),
            date: mo.date ?? .now
        )
    }
    
}
