import Foundation

struct FoodItem {
    let id: UUID?
    let name: String
    let brand: Brand?
    let nutritionInfo: NutritionInfo?
    let tags: [String]
    
    init(id: UUID? = nil, name: String, brand: Brand? = nil, nutritionInfo: NutritionInfo? = nil, tags: [String] = []) {
        self.id = id
        self.name = name
        self.brand = brand
        self.nutritionInfo = nutritionInfo
        self.tags = tags
    }
}
