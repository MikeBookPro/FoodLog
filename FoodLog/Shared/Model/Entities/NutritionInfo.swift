import Foundation

struct NutritionInfo {
    var servingSize: Quantity
    var nutrientQuantities: [Quantity]

    init(servingSize: Quantity, nutrientQuantities: [Quantity]) {
        self.servingSize = servingSize
        self.nutrientQuantities = nutrientQuantities
    }
}
