import SwiftUI

struct QuantityRowViewModel: Identifiable {
  let title: LocalizedStringKey
  let id: UUID
  let identifier: QuantityIdentifier
  var measurement: Measurement<Dimension>

  init(qty: Quantity) {
    self.id = qty.id
    self.identifier = qty.identifier
    self.measurement = qty.measurement
    self.title = IdentifierToLocalizedString.value(mappedTo: qty.identifier)
  }

  static func rows(for quantities: [Quantity]) -> [Self] {
    quantities.compactMap(Self.init(qty:))
  }
}
