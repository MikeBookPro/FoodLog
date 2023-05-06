import Foundation
import CoreData

// MARK: - Nutrition Info
//extension NutritionInfoMO: ImplementationWrapper  {
//    private var wrappedServingSize: any DietaryQuantityRepresentable {
//        if let serving = self.servingSize {
//            return serving.wrapped
//        } else {
//            return DietaryQuantity(quantity: Quantity(identifier: .servingSize, measurement: .init(value: .zero, unit: IdentifierToDimensionAdapter.value(mappedTo: .servingSize))))
//        }
//    }
//
//    private var wrappedNutrientQuantities: [any DietaryQuantityRepresentable] {
//        guard let nutrientQuantities = self.nutrientQuantities as? Set<NutrientQuantityMO> else { return [] }
//        return nutrientQuantities.map { $0.wrapped }
//    }
//
//    var wrapped: some NutritionInfoRepresentable {
//        NutritionInfo(servingSize: wrappedServingSize, nutrientQuantities: wrappedNutrientQuantities)
//    }
//}

// MARK: - Nutrient Quantity
//extension NutrientQuantityMO: ImplementationWrapper {
//    var wrappedNutritionInfo: (any NutritionInfoRepresentable)? {
//        guard let nutritionInfo = self.nutritionInfo else { return nil }
//        return nutritionInfo.wrapped
//    }
//
//    var wrapped: some DietaryQuantityRepresentable {
//        let identifier = QuantityIdentifier(string: self.quantityIdentifier)
//        return DietaryQuantity(
//            quantity: .init(
//                identifier: identifier,
//                measurement: .init(
//                    value: self.measurementValue,
//                    unit: IdentifierToDimensionAdapter.value(mappedTo: identifier)
//                )
//            ),
//            nutritionInfo: self.wrappedNutritionInfo
//        )
//    }
//}

// MARK: - Serving Size
//extension ServingSizeMO: ImplementationWrapper {
//    var wrappedNutritionInfo: (any NutritionInfoRepresentable)? {
//        guard let nutritionInfo = self.nutritionInfo else { return nil }
//        return nutritionInfo.wrapped
//    }
//    
//    var wrapped: some DietaryQuantityRepresentable {
//        return DietaryQuantity(
//            quantity: .init(
//                identifier: .servingSize,
//                measurement: .init(
//                    value: self.measurementValue,
//                    unit: IdentifierToDimensionAdapter.value(mappedTo: .servingSize)
//                )
//            ),
//            nutritionInfo: self.wrappedNutritionInfo
//        )
//    }
//}

// MARK: - Sample Quantity
extension SampleQuantityMO: ImplementationWrapper {
    var wrapped: some SampleQuantityRepresentable {
        let identifier = QuantityIdentifier(string: self.quantityIdentifier)
        return SampleQuantity(
            quantity: .init(
                identifier: identifier,
                measurement: .init(
                    value: self.measurementValue,
                    unit: IdentifierToDimensionAdapter.value(mappedTo: identifier)
                ),
                id: self.measurementID
            ),
            date: self.date ?? .now
        )
    }
}
