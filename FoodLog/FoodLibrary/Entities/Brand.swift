// import Foundation
//
// MARK: - Brand
//
// public protocol BrandReadable: Identifiable {
//    var id: UUID { get }
//    var name: String { get }
//
//    var productDetails: String? { get }
//
//    init(name: String)
// }
//
// public protocol BrandRepresentable: BrandReadable {
//    init(name: String)
// }
//
// MARK: - Nutrient
//
// public protocol NutrientReadable: Identifiable {
//    var id: String { get }
// }
//
// public protocol NutrientRepresentable: NutrientReadable {
//    init(id: String)
// }
//
// MARK: - NutrientQuantity
//
// public protocol NutrientQuantityReadable {
//    var nutrient: any NutrientReadable { get }
//    var quantity: any QuantityReadable { get }
// }
//
// public protocol NutrientQuantityRepresentable: NutrientQuantityReadable {
//    init(nutrient: some NutrientRepresentable, quantity: some QuantityRepresentable)
// }
//
// MARK: - Nutrition Info
//
// public protocol NutritionInfoReadable {
//    var servingSize: any QuantityReadable { get }
//    var nutrientQuantities: [any NutrientReadable] { get }
// }
//
// public protocol NutritionInfoRepresentable: NutritionInfoReadable {
//    init(servingSize: some QuantityRepresentable, nutrient: [any NutrientRepresentable])
// }
//
// MARK: - Food Item
//
// public protocol FoodItemReadable: Identifiable {
//    var id: UUID { get }
//    var nutritionInfo: any NutritionInfoReadable { get }
//    var itemDetail: any FoodItemDetailReadable { get }
// }
//
// public protocol FoodItemRepresentable: Identifiable {
//    init(id: UUID, nutritionInfo: some NutritionInfoRepresentable, itemDetail: some FoodItemDetailRepresentable)
// }
//
// MARK: - Tag
//
// public protocol TagReadable: Identifiable {
//    var id: UUID { get }
//    var text: String { get }
// }
//
// public protocol TagRepresentable: TagReadable {
//    init(text: String)
// }
//
// MARK: - Food Item Detail
//
// public protocol FoodItemDetailReadable {
//    var name: String? { get }
//    var nameSecondary: String? { get }
//    var preparationDetail: String? { get }
//    var tags: [any TagReadable] { get }
//    var brand: any BrandReadable { get }
// }
//
// public protocol FoodItemDetailRepresentable: FoodItemDetailReadable {
//    init(
//        name: String?,
//        nameSecondary: String?,
//        preparationDetail: String?,
//        tags: [any TagRepresentable],
//        brand: some BrandRepresentable
//    )
// }
