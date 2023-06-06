import Foundation
import SwiftUI

//enum IdentifierDimension {
//  static let prefersKilograms: QuantityIdentifierOption = [.bodyMass, .leanBodyMass]
//  static let prefersCentimeters: QuantityIdentifierOption = [.height, .waistCircumference]
//  static let prefersPercent: QuantityIdentifierOption = [.bodyFatPercentage]
//  static let prefersGrams: QuantityIdentifierOption = [
//    .fatTotal,
//    .fatSaturated,
//    .fatPolyunsaturated,
//    .fatMonounsaturated,
//    .carbohydrates,
//    .fiber,
//    .sugar,
//    .protein,
//  ]
//  static let prefersMilligrams: QuantityIdentifierOption = [
//    .cholesterol,
//    .calcium,
//    .chloride,
//    .copper,
//    .iron,
//    .magnesium,
//    .manganese,
//    .niacin,
//    .pantothenicAcid,
//    .phosphorus,
//    .potassium,
//    .riboflavin,
//    .sodium,
//    .thiamin,
//    .vitaminB6,
//    .vitaminC,
//    .zinc,
//  ]
//  static let prefersMicrograms: QuantityIdentifierOption = [
//    .biotin,
//    .chromium,
//    .folate,
//    .iodine,
//    .molybdenum,
//    .selenium,
//    .vitaminB12,
//    .vitaminK,
//  ]
//  static let prefersInternationalUnits: QuantityIdentifierOption = [
//    .vitaminA,
//    .vitaminD,
//    .vitaminE,
//  ]
//  static let prefersCalories: QuantityIdentifierOption = [ .energyConsumed ]
//}
//
//enum IdentifierToDimensionAdapter: Adapter {
//  private static func preferredUnit(forSelected option: QuantityIdentifierOption) -> Dimension {
//    // MARK: - Unit Mass
//    if IdentifierDimension.prefersKilograms.contains(option) { return UnitMass.kilograms }
//    if IdentifierDimension.prefersGrams.contains(option) { return UnitMass.grams }
//    if IdentifierDimension.prefersMilligrams.contains(option) { return UnitMass.milligrams }
//    if IdentifierDimension.prefersMicrograms.contains(option) { return UnitMass.micrograms }
//
//    // MARK: - Unit Energy
//    if IdentifierDimension.prefersCalories.contains(option) { return UnitEnergy.kilocalories}
//
//    // MARK: - Unit Length
//    if IdentifierDimension.prefersCentimeters.contains(option) { return UnitLength.centimeters }
//
//    // MARK: - Unit Count
//    if IdentifierDimension.prefersPercent.contains(option) { return UnitCount.percent }
//
//    // MARK: - Unit Pharmacology
//    if IdentifierDimension.prefersInternationalUnits.contains(option) { return UnitPharmacology.internationalUnit }
//
//    return UnitUnknown.unknown
//  }
//
//  static func value(mappedTo source: QuantityIdentifier) -> Dimension {
//    let option = IdentifierToOptionAdapter.value(mappedTo: source)
//    return preferredUnit(forSelected: option)
//  }
//}
