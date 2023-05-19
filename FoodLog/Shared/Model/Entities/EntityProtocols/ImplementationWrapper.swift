import Foundation

protocol ImplementationWrapper {
  associatedtype Wrapped
  var wrapped: Wrapped { get }
}

// MARK: Quantity Representable
extension ImplementationWrapper where Self: QuantityRepresentable, Wrapped: QuantityRepresentable {
  var identifier: QuantityIdentifier { wrapped[keyPath: \.identifier] }

  var id: UUID { wrapped[keyPath: \.id] }

  var measurement: Measurement<Dimension> { wrapped[keyPath: \.measurement] }
}

// MARK: Sample Quantity Representable
extension ImplementationWrapper where Self: SampleQuantityRepresentable, Wrapped: SampleQuantityRepresentable {
  var date: Date { wrapped[keyPath: \.date] }
}

// MARK: Dietary Quantity Representable
extension ImplementationWrapper where Self: DietaryQuantityRepresentable, Wrapped: DietaryQuantityRepresentable {
  var nutritionInfo: (any NutritionInfoRepresentable)? { wrapped[keyPath: \.nutritionInfo] }
}
