import Foundation

//extension SampleQuantityMO

extension NutrientQuantityMO: QuantityRepresentable, ImplementationWrapper {
    var wrapped: Quantity {
        let identifier = QuantityIdentifier(string: self.quantityIdentifier)
        return .init(
            identifier: identifier,
            measurement: .init(
                value: self.measurementValue,
                unit: IdentifierToDimensionAdapter.value(mappedTo: identifier)
            ),
            id: self.measurementID
        )
    }
}

extension ServingSizeMO: QuantityRepresentable, ImplementationWrapper {
    var wrapped: Quantity {
        let identifier = QuantityIdentifier(string: self.quantityIdentifier)
        return .init(
            identifier: identifier,
            measurement: .init(
                value: self.measurementValue,
                unit: IdentifierToDimensionAdapter.value(mappedTo: identifier)
            ),
            id: self.measurementID
        )
    }
}

//extension ObservedQuantityMO: SampleQuantityRepresentable, ImplementationWrapper {
//    var wra
//}
//extension ObservedQuantityMO
