import Foundation

// MARK: - Reference Quantities
protocol ReferenceQuantityRepresentable {
    var measurementID: UUID? { get }
    var measurementUnit: String? { get }
    var measurementValue: String? { get }
    var quantityIdentifier: String? { get }
}

protocol NutrientQuantityRepresentable: ReferenceQuantityRepresentable {
//    var nutrutionInfo: NutritionInfoRepresentable? { get }
}

protocol ServingSizeRepresentable: ReferenceQuantityRepresentable {
//    var nutrutionInfo: NutritionInfoRepresentable? { get }
}

// MARK: - Timestamped Quantities

protocol ObservedQuantityRepresentable: ReferenceQuantityRepresentable {
    var date: Date? { get }
}
