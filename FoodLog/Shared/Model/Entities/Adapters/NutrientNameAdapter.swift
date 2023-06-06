import Foundation
import SwiftUI

enum NutrientNameAdapter: Adapter {
  private static let localizations: [UInt64: LocalizedStringKey] = [
    0: "QuantityIdentifierLabel_biotin",
    1: "QuantityIdentifierLabel_caffeine",
    2: "QuantityIdentifierLabel_calcium",
    3: "QuantityIdentifierLabel_carbohydrates",
    4: "QuantityIdentifierLabel_chloride",
    5: "QuantityIdentifierLabel_cholesterol",
    6: "QuantityIdentifierLabel_chromium",
    7: "QuantityIdentifierLabel_copper",
    8: "QuantityIdentifierLabel_energyConsumed",
    9: "QuantityIdentifierLabel_fatMonounsaturated",
    10: "QuantityIdentifierLabel_fatPolyunsaturated",
    11: "QuantityIdentifierLabel_fatSaturated",
    12: "QuantityIdentifierLabel_fatTotal",
    13: "QuantityIdentifierLabel_fiber",
    14: "QuantityIdentifierLabel_folate",
    15: "QuantityIdentifierLabel_iodine",
    16: "QuantityIdentifierLabel_iron",
    17: "QuantityIdentifierLabel_magnesium",
    18: "QuantityIdentifierLabel_manganese",
    19: "QuantityIdentifierLabel_molybdenum",
    20: "QuantityIdentifierLabel_niacin",
    21: "QuantityIdentifierLabel_pantothenicAcid",
    22: "QuantityIdentifierLabel_phosphorus",
    23: "QuantityIdentifierLabel_potassium",
    24: "QuantityIdentifierLabel_protein",
    25: "QuantityIdentifierLabel_riboflavin",
    26: "QuantityIdentifierLabel_selenium",
    27: "QuantityIdentifierLabel_sodium",
    28: "QuantityIdentifierLabel_sugar",
    29: "QuantityIdentifierLabel_thiamin",
    30: "QuantityIdentifierLabel_vitaminA",
    31: "QuantityIdentifierLabel_vitaminB12",
    32: "QuantityIdentifierLabel_vitaminB6",
    33: "QuantityIdentifierLabel_vitaminC",
    34: "QuantityIdentifierLabel_vitaminD",
    35: "QuantityIdentifierLabel_vitaminE",
    36: "QuantityIdentifierLabel_vitaminK",
    37: "QuantityIdentifierLabel_water",
    38: "QuantityIdentifierLabel_zinc",
  ]

  static func value(mappedTo source: Nutrient) -> LocalizedStringKey {
    localizations[source.rawValue, default: "<_Unknown_>"]
  }
}
