import Foundation

struct SampleQuantity: SampleQuantityRepresentable, ImplementationWrapper, Equatable, Hashable {
    // MARK: Sample Quantity Representable
    let date: Date
    
    // MARK: Implementation Wrapper
    let wrapped: Quantity
    
    // MARK: Initializer
    init(quantity: Quantity, date: Date) {
        self.wrapped = quantity
        self.date = date
    }
    
    static func copy(from opaque: some SampleQuantityRepresentable) -> Self {
        return .init(
            quantity: .init(
                identifier: opaque.identifier,
                measurement: opaque.measurement,
                id: opaque.id
            ),
            date: opaque.date
        )
    }
    
    static func == (_ lhs: SampleQuantity, _ rhs: SampleQuantity) -> Bool {
        lhs.id == rhs.id &&
        lhs.identifier == rhs.identifier &&
        lhs.measurement == rhs.measurement &&
        lhs.date == rhs.date
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(identifier)
        hasher.combine(measurement)
        hasher.combine(date)
    }
}
