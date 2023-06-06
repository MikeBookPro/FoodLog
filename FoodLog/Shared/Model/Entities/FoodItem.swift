import Foundation

struct FoodItem: Identifiable {
  let id: UUID
  let name: String
  let nutritionInfo: [NutritionInfo]
  let brand: Brand

  init(name: String, nutritionInfo: [NutritionInfo], id: UUID? = nil, brand: Brand? = nil) {
    self.id = id ?? .init()
    self.name = name
    self.nutritionInfo = nutritionInfo
    self.brand = brand ?? .generic
  }
}
