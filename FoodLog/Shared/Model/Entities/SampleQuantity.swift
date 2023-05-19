import Foundation

struct SampleQuantity: SampleQuantityRepresentable, ImplementationWrapper, EditableModel, Equatable, Hashable {
  // MARK: Sample Quantity Representable
  let date: Date

  // MARK: Implementation Wrapper
  let wrapped: Quantity

  // MARK: Initializer
  init(quantity: Quantity, date: Date) {
    self.wrapped = quantity
    self.date = date
  }

  // MARK: EditableModel
  static func template(for identifier: QuantityIdentifier) -> Self {
    return .init(
      quantity: .init(
        identifier: identifier,
        measurement: .init(
          value: .zero,
          unit: IdentifierToDimensionAdapter.value(mappedTo: identifier)
        )
      ),
      date: .now
    )
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
