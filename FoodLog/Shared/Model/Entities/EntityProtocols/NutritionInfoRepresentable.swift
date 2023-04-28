import Foundation

protocol NutritionInfoRepresentable {
    var nutrientQuantities: [any NutrientQuantityRepresentable]? { get }
    var servingSize: (any ServingSizeRepresentable)? { get }
}
