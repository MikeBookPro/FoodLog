import Foundation

struct DietaryQuantity: DietaryQuantityRepresentable, ImplementationWrapper {
  // MARK: Nutrient Quantity Representable
  var nutritionInfo: (any NutritionInfoRepresentable)?

  // MARK: Implementation Wrapper
  let wrapped: Quantity

  // MARK: Initilizer
  init(quantity: Quantity, nutritionInfo: (any NutritionInfoRepresentable)? = nil) {
    self.nutritionInfo = nutritionInfo
    self.wrapped = quantity
  }
}
