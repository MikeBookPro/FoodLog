import Foundation

struct FoodItem: Hashable, Equatable {
    let id: UUID?
    let name: String
    let brand: Brand?
    let nutritionInfo: NutritionInfo
    let tags: [String]
    
    init(id: UUID = .init(), name: String, brand: Brand? = nil, nutritionInfo: NutritionInfo, tags: [String] = []) {
        self.id = id
        self.name = name
        self.brand = brand
        self.nutritionInfo = nutritionInfo
        self.tags = tags
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(tags)
    }
    
    static func == (lhs: FoodItem, rhs: FoodItem) -> Bool {
        lhs.id == rhs.id
    }
}
