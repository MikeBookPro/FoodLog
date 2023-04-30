import Foundation

struct Quantity: QuantityRepresentable {
    let identifier: QuantityIdentifier
    let id: UUID?
    var measurement: Measurement<Dimension>
    
    
    init(identifier: QuantityIdentifier, measurement: Measurement<Dimension>, id: UUID? = nil) {
        self.id = id
        self.identifier = identifier
        self.measurement = measurement
    }
    
    static func copy(from opaque: any QuantityRepresentable) -> Self {
        return .init(
            identifier: opaque.identifier,
            measurement: opaque.measurement
        )
    }
}
