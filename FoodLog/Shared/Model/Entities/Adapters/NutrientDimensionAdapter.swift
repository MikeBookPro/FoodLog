import Foundation

enum NutrientDimensionAdapter: Adapter {
  private static let prefersGrams: Nutrient.Option = [
    .fatTotal,
    .fatSaturated,
    .fatPolyunsaturated,
    .fatMonounsaturated,
    .carbohydrates,
    .fiber,
    .sugar,
    .protein,
  ]
  private static let prefersMilligrams: Nutrient.Option = [
    .cholesterol,
    .calcium,
    .chloride,
    .copper,
    .iron,
    .magnesium,
    .manganese,
    .niacin,
    .pantothenicAcid,
    .phosphorus,
    .potassium,
    .riboflavin,
    .sodium,
    .thiamin,
    .vitaminB6,
    .vitaminC,
    .zinc,
  ]
  private static let prefersMicrograms: Nutrient.Option = [
    .biotin,
    .chromium,
    .folate,
    .iodine,
    .molybdenum,
    .selenium,
    .vitaminB12,
    .vitaminK,
  ]
  private static let prefersInternationalUnits: Nutrient.Option = [
    .vitaminA,
    .vitaminD,
    .vitaminE,
  ]
  private static let prefersCalories: Nutrient.Option = [ .energyConsumed ]

  static func value(mappedTo source: Nutrient) -> Dimension {
    if prefersGrams.contains(source.option) { return UnitMass.grams }
    if prefersMilligrams.contains(source.option) { return UnitMass.milligrams }
    if prefersMicrograms.contains(source.option) { return UnitMass.micrograms }

    // MARK: - Unit Energy
    if prefersCalories.contains(source.option) { return UnitEnergy.kilocalories}

    // MARK: - Unit Pharmacology
    if prefersInternationalUnits.contains(source.option) { return UnitPharmacology.internationalUnit }

    return UnitUnknown.unknown
  }
}
