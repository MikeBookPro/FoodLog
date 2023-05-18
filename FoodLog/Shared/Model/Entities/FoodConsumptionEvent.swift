import Foundation

struct FoodConsumptionEvent: Identifiable, Hashable, Equatable {
    let foodItem: FoodItem
    let quantity: Quantity
    let date: Date
    
    var id: UUID { self.quantity.id }
    
    init(food item: FoodItem, sample: Quantity? = nil, date: Date = .now) {
        self.foodItem = item
        self.quantity = sample ?? .init(identifier: .food, measurement: .init(value: .zero, unit: UnitMass.grams))
        self.date = date
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(foodItem)
        hasher.combine(date)
    }
    
    static func == (lhs: FoodConsumptionEvent, rhs: FoodConsumptionEvent) -> Bool {
        lhs.id == rhs.id
    }
}


/**
 let date = NSDate()

 // Create a sample for calories
 guard let calorieType = HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryEnergyConsumed) else { fatalError("*** Unable to create the calorie type ***") }
 let calorieQuantity = HKQuantity(unit: HKUnit.kilocalorieUnit(), doubleValue: 110.0)
 let calorieSample = HKQuantitySample(type: calorieType, quantity: calorieQuantity, startDate: date, endDate: date)
  
 // Create a sample for total fat
 guard let fatType = HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryFatTotal) else { fatalError("*** Unable to create the fat type ***") }
 let fatQuantity = HKQuantity(unit: HKUnit.gramUnit(), doubleValue: 0.0)
 let fatSample = HKQuantitySample(type: fatType, quantity: fatQuantity, startDate: date, endDate: date)
  
 // Create a sample for carbohydrates
 guard let carbohydratesType = HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryCarbohydrates) else { fatalError("*** Unable to create the carbohydrates type ***") }
 let carbohydratesQuantity = HKQuantity(unit: HKUnit.gramUnit(), doubleValue: 30.0)
 let carbohydratesSample = HKQuantitySample(type: carbohydratesType, quantity: carbohydratesQuantity, startDate: date, endDate: date)
  
 // Create a sample for protein
 guard let proteinType = HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDietaryProtein) else { fatalError("*** Unable to create the protein type ***") }
  
 let proteinQuantity = HKQuantity(unit: HKUnit.gramUnit(), doubleValue: 1.0)
 let proteinSample = HKQuantitySample(type: proteinType, quantity: proteinQuantity, startDate: date, endDate: date)
  
 // Create the food sample
 let objects: Set = [calorieSample, fatSample, carbohydratesSample, proteinSample]
 let metadata = [HKMetadataKeyFoodType: "Banana"]
 
 guard let bananaType = HKObjectType.correlationTypeForIdentifier(HKCorrelationTypeIdentifierFood) else { fatalError("*** Unable to create the banana type ***") }
 let banana = HKCorrelation(
    type: bananaType,
    startDate: date,
    endDate: date,
    objects: objects,
    metadata: [HKMetadataKeyFoodType: "Banana"]
 )
                            
 */
