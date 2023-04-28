import Foundation

// MARK: - Reference Quantities
protocol QuantityRepresentable: Identifiable {
    var identifier: QuantityIdentifier { get }
    var measurement: Measurement<Dimension> { get }
    var id: UUID? { get }
}

protocol ReferenceQuantityRepresentable: QuantityRepresentable {}
protocol ObservedQuantityRepresentable: QuantityRepresentable {
    var date: Date? { get }
}

// MARK: - Reference Quantities

protocol NutritionInfoRepresentable {
    var servingSize: (any DietaryQuantityRepresentable)? { get }
    var nutrientQuantities: [any DietaryQuantityRepresentable] { get }
}

protocol DietaryQuantityRepresentable: ReferenceQuantityRepresentable {
    var nutritionInfo: (any NutritionInfoRepresentable)? { get }
}

// MARK: - Timestamped Quantities

//TODO: Will need to make a bunch of different SampleQuantity (probably)
protocol SampleQuantityRepresentable: ReferenceQuantityRepresentable {
    var date: Date { get }
}
