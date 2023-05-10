import Foundation

struct Quantity: QuantityRepresentable, EditableModel {
    let identifier: QuantityIdentifier
    let id: UUID
    var measurement: Measurement<Dimension>
    
    init(identifier: QuantityIdentifier, measurement: Measurement<Dimension>, id: UUID? = nil) {
        self.id = id ?? .init()
        self.identifier = identifier
        self.measurement = measurement
    }
    
    static func copy(from opaque: any QuantityRepresentable) -> Self {
        return .init(
            identifier: opaque.identifier,
            measurement: opaque.measurement,
            id: opaque.id
        )
    }
    
    // MARK: EditableModel
    static func template(for identifier: QuantityIdentifier) -> Self {
        .init(
            identifier: identifier,
            measurement: .init(
                value: .zero,
                unit: IdentifierToDimensionAdapter.value(mappedTo: identifier)
            )
        )
    }
    
    struct Builder {
        private(set) var quantity: Quantity
        
        private init(quantity: Quantity) {
            self.quantity = quantity
        }
        
        static func template(for identifier: QuantityIdentifier) -> Self {
            self.init(
                quantity: .init(
                    identifier: identifier,
                    measurement: .init(
                        value: .zero,
                        unit: IdentifierToDimensionAdapter.value(mappedTo: identifier)
                    ),
                    id: UUID()
                )
            )
        }
        
        func update<Value>(value: Value, for keyPath: KeyPath<Quantity, Value>) -> Self {
            if keyPath == \.measurement.value, let val = value as? Double {
                return .init(quantity: Quantity(identifier: quantity.identifier, measurement: .init(value: val, unit: quantity.measurement.unit)))
            }
            
            if keyPath == \.measurement.unit, let dim = value as? Dimension {
                return .init(quantity: Quantity(identifier: quantity.identifier, measurement: .init(value: quantity.measurement.value, unit: dim)))
            }
            
            if keyPath == \.measurement, let measure = value as? Measurement<Dimension> {
                return .init(quantity: Quantity(identifier: quantity.identifier, measurement: measure))
            }
            
            return self
        }
        
    }
}
