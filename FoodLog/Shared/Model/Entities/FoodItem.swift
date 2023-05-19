import Foundation

struct FoodItem: EditableModel, Hashable, Equatable, Identifiable {
  let id: UUID
  let name: String
  let brand: Brand?
  let nutritionInfo: NutritionInfo
  let tags: [String]

  init(id: UUID? = nil, name: String, brand: Brand? = nil, nutritionInfo: NutritionInfo, tags: [String] = []) {
    self.id = id ?? .init()
    self.name = name
    self.brand = brand
    self.nutritionInfo = nutritionInfo
    self.tags = tags
  }

  // MARK: EditableModel
  static func template(for identifier: QuantityIdentifier) -> FoodItem {
    FoodItem(
      name: .empty,
      nutritionInfo: NutritionInfo(
        servingSize: .init(identifier: .servingSize, measurement: UnitMass.grams.empty),
        nutrientQuantities: [
          QuantityIdentifier.energyConsumed,
          QuantityIdentifier.fatTotal,
          QuantityIdentifier.fatSaturated,
          QuantityIdentifier.cholesterol,
          QuantityIdentifier.sodium,
          QuantityIdentifier.carbohydrates,
          QuantityIdentifier.fiber,
          QuantityIdentifier.sugar,
          QuantityIdentifier.protein,
          QuantityIdentifier.vitaminA,
          QuantityIdentifier.vitaminC,
          QuantityIdentifier.iron,
          QuantityIdentifier.calcium,
        ].map(Quantity.template(for:))
      )
    )
  }

  // MARK: Hashable
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
    hasher.combine(name)
    hasher.combine(tags)
  }

  // MARK: Equatable
  static func == (lhs: FoodItem, rhs: FoodItem) -> Bool {
    lhs.id == rhs.id
  }
}
