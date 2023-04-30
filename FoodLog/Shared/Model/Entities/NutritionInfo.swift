import Foundation

struct NutritionInfo: NutritionInfoRepresentable {
    var servingSize: (any DietaryQuantityRepresentable)?
    var nutrientQuantities: [any DietaryQuantityRepresentable]
    
    init(servingSize: any DietaryQuantityRepresentable, nutrientQuantities: [any DietaryQuantityRepresentable]) {
        self.servingSize = servingSize
        self.nutrientQuantities = nutrientQuantities
    }
}
