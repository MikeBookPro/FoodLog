import Foundation

struct BodyWeightSampleAdapter {

    static func adapt(sampleQuantity mo: SampleQuantityMO) -> SampleQuantity {
        let quantityIdentifier: QuantityIdentifier = .init(string: mo.quantityIdentifier)
        return SampleQuantity(
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
