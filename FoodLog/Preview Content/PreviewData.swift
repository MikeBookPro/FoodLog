import Foundation

enum PreviewData {
    static func quantities(for identifier: QuantityIdentifier, count: Int, in range: ClosedRange<Double> ) -> [Quantity] {
        let dimension: Dimension = IdentifierToDimensionAdapter.value(mappedTo: identifier)
        return Array(0..<count).reduce(into: [Quantity]()) { (partialResult, _) in
            partialResult.append(
                Quantity(
                    identifier: identifier,
                    measurement: .init(
                        value: Double.random(in: range),
                        unit: dimension
                    ),
                    id: UUID()
                )
            )
        }
    }
    
    private static func consecutiveDates(count: Int) -> [Date] {
        let now = Date.now
        var dateComponents = DateComponents()
        dateComponents.day = 0
        return Array(0..<count).reduce(into: [Date]()) { (partialResult, i) in
            dateComponents.day = -i
            guard let date = Calendar.current.date(byAdding: dateComponents, to: now) else { return }
            partialResult.append(date)
        }
    }
    
    static func quantitySamples(for identifier: QuantityIdentifier, count: Int, in range: ClosedRange<Double>) -> [SampleQuantity] {
        let quantities = Self.quantities(for: identifier, count: count, in: range)
        let dates = Self.consecutiveDates(count: count)
        return zip(quantities, dates).map(SampleQuantity.init(quantity:date:))
    }
    
    enum Food {
        static let cheese = FoodItem(
            name: "Cheese",
            brand: Brand(name: "Kerry Gold"),
            nutritionInfo: NutritionInfo(
                servingSize: .init(identifier: .servingSize, measurement: .init(value: 28.0, unit: UnitMass.grams)),
                nutrientQuantities: [
                    .init(identifier: .energyConsumed, measurement: .init(value: 110, unit: UnitEnergy.kilocalories)),
                    .init(identifier: .fatTotal, measurement: .init(value: 9, unit: UnitMass.grams)),
                    .init(identifier: .fatSaturated, measurement: .init(value: 9, unit: UnitMass.grams)),
                    .init(identifier: .sodium, measurement: .init(value: 210, unit: UnitMass.milligrams)),
                    .init(identifier: .carbohydrates, measurement: .init(value: 0, unit: UnitMass.grams)),
                    .init(identifier: .protein, measurement: .init(value: 7, unit: UnitMass.grams)),
                ]
            )
        )
        
        static let egg = FoodItem(
            name: "Egg",
            brand: .generic,
            nutritionInfo: NutritionInfo(
                servingSize: .init(identifier: .servingSize, measurement: .init(value: 1, unit: UnitCount.integer)),
                nutrientQuantities: [
                    .init(identifier: .energyConsumed, measurement: .init(value: 68, unit: UnitEnergy.kilocalories)),
                    .init(identifier: .fatTotal, measurement: .init(value: 4, unit: UnitMass.grams)),
                    .init(identifier: .fatSaturated, measurement: .init(value: 1.5, unit: UnitMass.grams)),
                    .init(identifier: .sodium, measurement: .init(value: 60, unit: UnitMass.milligrams)),
                    .init(identifier: .carbohydrates, measurement: .init(value: 0, unit: UnitMass.grams)),
                    .init(identifier: .protein, measurement: .init(value: 6, unit: UnitMass.grams)),
                ]
            )
        )
        
        static let mayonnaise = FoodItem(
            name: "Mayonnaise",
            brand: Brand(name: "Best Foods"),
            nutritionInfo: NutritionInfo(
                servingSize: .init(identifier: .servingSize, measurement: .init(value: 14, unit: UnitMass.grams)),
                nutrientQuantities: [
                    .init(identifier: .energyConsumed, measurement: .init(value: 100, unit: UnitEnergy.kilocalories)),
                    .init(identifier: .fatTotal, measurement: .init(value: 11, unit: UnitMass.grams)),
                    .init(identifier: .fatSaturated, measurement: .init(value: 1.5, unit: UnitMass.grams)),
                    .init(identifier: .sodium, measurement: .init(value: 100, unit: UnitMass.milligrams)),
                    .init(identifier: .carbohydrates, measurement: .init(value: 0, unit: UnitMass.grams)),
                    .init(identifier: .protein, measurement: .init(value: 0, unit: UnitMass.grams)),
                ]
            )
        )
        
        static let sardines = FoodItem(
            name: "Sardines",
            brand: Brand(name: "Season Brand"),
            nutritionInfo: NutritionInfo(
                servingSize: .init(identifier: .servingSize, measurement: .init(value: 1, unit: UnitCount.integer)),
                nutrientQuantities: [
                    .init(identifier: .energyConsumed, measurement: .init(value: 200, unit: UnitEnergy.kilocalories)),
                    .init(identifier: .fatTotal, measurement: .init(value: 12, unit: UnitMass.grams)),
                    .init(identifier: .fatSaturated, measurement: .init(value: 3, unit: UnitMass.grams)),
                    .init(identifier: .sodium, measurement: .init(value: 340, unit: UnitMass.milligrams)),
                    .init(identifier: .carbohydrates, measurement: .init(value: 0, unit: UnitMass.grams)),
                    .init(identifier: .protein, measurement: .init(value: 22, unit: UnitMass.grams)),
                ]
            ),
            tags: ["Canned"]
        )
        
        static let tuna = FoodItem(
            name: "Tuna",
            brand: Brand(name: "Wild Planet"),
            nutritionInfo: NutritionInfo(
                servingSize: .init(identifier: .servingSize, measurement: .init(value: 1, unit: UnitCount.integer)),
                nutrientQuantities: [
                    .init(identifier: .energyConsumed, measurement: .init(value: 150, unit: UnitEnergy.kilocalories)),
                    .init(identifier: .fatTotal, measurement: .init(value: 4, unit: UnitMass.grams)),
                    .init(identifier: .fatSaturated, measurement: .init(value: 1.5, unit: UnitMass.grams)),
                    .init(identifier: .sodium, measurement: .init(value: 200, unit: UnitMass.milligrams)),
                    .init(identifier: .carbohydrates, measurement: .init(value: 0, unit: UnitMass.grams)),
                    .init(identifier: .protein, measurement: .init(value: 21, unit: UnitMass.grams)),
                ]
            ),
            tags: ["Canned"]
        )
    }
    
    static let foodItems: [FoodItem] = [
        PreviewData.Food.cheese,
        PreviewData.Food.egg,
        PreviewData.Food.mayonnaise,
        PreviewData.Food.sardines,
        PreviewData.Food.tuna,
    ]
    
    static func consumptionEvents(forFood item: FoodItem, count: Int) -> [FoodConsumptionEvent] {
        let servingSize = item.nutritionInfo.servingSize.measurement.value
        let range = (servingSize / 2)...(servingSize * 2)
        let servingQuantities = quantities(for: .servingSize, count: count, in: range)
        let dates = Self.consecutiveDates(count: count)
        return zip(servingQuantities, dates).map { (servingSize, date) in
            FoodConsumptionEvent(food: item, sample: servingSize, date: date)
        }
        
    }
}
