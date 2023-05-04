import Foundation

enum PreviewData {
    static func quantities(for identifier: QuantityIdentifier, count: Int, in range: ClosedRange<Double> ) -> [Quantity] {
        let dimension: Dimension = IdentifierToDimensionAdapter.value(mappedTo: identifier)
        return Array(0..<count).reduce(into: [Quantity]()) { (partialResult, _) in
            partialResult.append(
                Quantity(
                    identifier: identifier,
                    measurement: .init(
                        value: Double.random(in: range),
                        unit: dimension
                    ),
                    id: UUID()
                )
            )
        }
    }
    
    private static func consecutiveDates(count: Int) -> [Date] {
        let now = Date.now
        var dateComponents = DateComponents()
        dateComponents.day = 0
        return Array(0..<count).reduce(into: [Date]()) { (partialResult, i) in
            dateComponents.day = -i
            guard let date = Calendar.current.date(byAdding: dateComponents, to: now) else { return }
            partialResult.append(date)
        }
    }
    
    static func quantitySamples(for identifier: QuantityIdentifier, count: Int, in range: ClosedRange<Double>) -> [SampleQuantity] {
        let quantities = Self.quantities(for: identifier, count: count, in: range)
        let dates = Self.consecutiveDates(count: count)
        return zip(quantities, dates).map(SampleQuantity.init(quantity:date:))
    }
}
