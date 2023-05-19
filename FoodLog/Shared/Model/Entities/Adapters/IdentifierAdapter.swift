import Foundation
import SwiftUI

enum IdentifierToOptionAdapter: Adapter {
    typealias Source = QuantityIdentifier
    typealias Destination = QuantityIdentifierOption

    static func value(mappedTo source: QuantityIdentifier) -> QuantityIdentifierOption {
        switch source {
            case .unknown: return .unknown
            case .height: return .height
            case .bodyMass: return .bodyMass
            case .leanBodyMass: return .leanBodyMass
            case .bodyFatPercentage: return .bodyFatPercentage
            case .waistCircumference: return .waistCircumference
            case .bloodGlucose: return .bloodGlucose
            case .servingSize: return .servingSize
            case .food: return .food
            case .biotin: return .biotin
            case .caffeine: return .caffeine
            case .calcium: return .calcium
            case .carbohydrates: return .carbohydrates
            case .chloride: return .chloride
            case .cholesterol: return .cholesterol
            case .chromium: return .chromium
            case .copper: return .copper
            case .energyConsumed: return .energyConsumed
            case .fatMonounsaturated: return .fatMonounsaturated
            case .fatPolyunsaturated: return .fatPolyunsaturated
            case .fatSaturated: return .fatSaturated
            case .fatTotal: return .fatTotal
            case .fiber: return .fiber
            case .folate: return .folate
            case .iodine: return .iodine
            case .iron: return .iron
            case .magnesium: return .magnesium
            case .manganese: return .manganese
            case .molybdenum: return .molybdenum
            case .niacin: return .niacin
            case .pantothenicAcid: return .pantothenicAcid
            case .phosphorus: return .phosphorus
            case .potassium: return .potassium
            case .protein: return .protein
            case .riboflavin: return .riboflavin
            case .selenium: return .selenium
            case .sodium: return .sodium
            case .sugar: return .sugar
            case .thiamin: return .thiamin
            case .vitaminA: return .vitaminA
            case .vitaminB12: return .vitaminB12
            case .vitaminB6: return .vitaminB6
            case .vitaminC: return .vitaminC
            case .vitaminD: return .vitaminD
            case .vitaminE: return .vitaminE
            case .vitaminK: return .vitaminK
            case .water: return .water
            case .zinc: return .zinc
        }
    }
}

enum IdentifierDimension {
    static let prefersKilograms: QuantityIdentifierOption = [.bodyMass, .leanBodyMass]
    static let prefersCentimeters: QuantityIdentifierOption = [.height, .waistCircumference]
    static let prefersPercent: QuantityIdentifierOption = [.bodyFatPercentage]
    static let prefersGrams: QuantityIdentifierOption = [
        .fatTotal,
        .fatSaturated,
        .fatPolyunsaturated,
        .fatMonounsaturated,
        .carbohydrates,
        .fiber,
        .sugar,
        .protein
    ]
    static let prefersMilligrams: QuantityIdentifierOption = [
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
        .zinc
    ]
    static let prefersMicrograms: QuantityIdentifierOption = [
        .biotin,
        .chromium,
        .folate,
        .iodine,
        .molybdenum,
        .selenium,
        .vitaminB12,
        .vitaminK
    ]
    static let prefersInternationalUnits: QuantityIdentifierOption = [
        .vitaminA,
        .vitaminD,
        .vitaminE
    ]
    static let prefersCalories: QuantityIdentifierOption = [ .energyConsumed ]
}

enum IdentifierToDimensionAdapter: Adapter {
    private static func preferredUnit(forSelected option: QuantityIdentifierOption) -> Dimension {
        // MARK: - Unit Mass
        if IdentifierDimension.prefersKilograms.contains(option) { return UnitMass.kilograms }
        if IdentifierDimension.prefersGrams.contains(option) { return UnitMass.grams }
        if IdentifierDimension.prefersMilligrams.contains(option) { return UnitMass.milligrams }
        if IdentifierDimension.prefersMicrograms.contains(option) { return UnitMass.micrograms }

        // MARK: - Unit Energy
        if IdentifierDimension.prefersCalories.contains(option) { return UnitEnergy.kilocalories}

        // MARK: - Unit Length
        if IdentifierDimension.prefersCentimeters.contains(option) { return UnitLength.centimeters }

        // MARK: - Unit Count
        if IdentifierDimension.prefersPercent.contains(option) { return UnitCount.percent }

        // MARK: - Unit Pharmacology
        if IdentifierDimension.prefersInternationalUnits.contains(option) { return UnitPharmacology.internationalUnit }

        return UnitUnknown.unknown
    }

    static func value(mappedTo source: QuantityIdentifier) -> Dimension {
        let option = IdentifierToOptionAdapter.value(mappedTo: source)
        return preferredUnit(forSelected: option)
    }
}

enum IdentifierToLocalizedString {
    static func value(mappedTo source: QuantityIdentifier) -> LocalizedStringKey {
        switch source {
            case .unknown: return "QuantityIdentifierLabel_unknown"
            case .height: return "QuantityIdentifierLabel_height"
            case .bodyMass: return "QuantityIdentifierLabel_bodyMass"
            case .leanBodyMass: return "QuantityIdentifierLabel_leanBodyMass"
            case .bodyFatPercentage: return "QuantityIdentifierLabel_bodyFatPercentage"
            case .waistCircumference: return "QuantityIdentifierLabel_waistCircumference"
            case .bloodGlucose: return "QuantityIdentifierLabel_bloodGlucose"
            case .servingSize: return "QuantityIdentifierLabel_servingSize"
            case .biotin: return "QuantityIdentifierLabel_biotin"
            case .caffeine: return "QuantityIdentifierLabel_caffeine"
            case .calcium: return "QuantityIdentifierLabel_calcium"
            case .carbohydrates: return "QuantityIdentifierLabel_carbohydrates"
            case .chloride: return "QuantityIdentifierLabel_chloride"
            case .cholesterol: return "QuantityIdentifierLabel_cholesterol"
            case .chromium: return "QuantityIdentifierLabel_chromium"
            case .copper: return "QuantityIdentifierLabel_copper"
            case .energyConsumed: return "QuantityIdentifierLabel_energyConsumed"
            case .fatMonounsaturated: return "QuantityIdentifierLabel_fatMonounsaturated"
            case .fatPolyunsaturated: return "QuantityIdentifierLabel_fatPolyunsaturated"
            case .fatSaturated: return "QuantityIdentifierLabel_fatSaturated"
            case .fatTotal: return "QuantityIdentifierLabel_fatTotal"
            case .fiber: return "QuantityIdentifierLabel_fiber"
            case .folate: return "QuantityIdentifierLabel_folate"
            case .iodine: return "QuantityIdentifierLabel_iodine"
            case .iron: return "QuantityIdentifierLabel_iron"
            case .magnesium: return "QuantityIdentifierLabel_magnesium"
            case .manganese: return "QuantityIdentifierLabel_manganese"
            case .molybdenum: return "QuantityIdentifierLabel_molybdenum"
            case .niacin: return "QuantityIdentifierLabel_niacin"
            case .pantothenicAcid: return "QuantityIdentifierLabel_pantothenicAcid"
            case .phosphorus: return "QuantityIdentifierLabel_phosphorus"
            case .potassium: return "QuantityIdentifierLabel_potassium"
            case .protein: return "QuantityIdentifierLabel_protein"
            case .riboflavin: return "QuantityIdentifierLabel_riboflavin"
            case .selenium: return "QuantityIdentifierLabel_selenium"
            case .sodium: return "QuantityIdentifierLabel_sodium"
            case .sugar: return "QuantityIdentifierLabel_sugar"
            case .thiamin: return "QuantityIdentifierLabel_thiamin"
            case .vitaminA: return "QuantityIdentifierLabel_vitaminA"
            case .vitaminB12: return "QuantityIdentifierLabel_vitaminB12"
            case .vitaminB6: return "QuantityIdentifierLabel_vitaminB6"
            case .vitaminC: return "QuantityIdentifierLabel_vitaminC"
            case .vitaminD: return "QuantityIdentifierLabel_vitaminD"
            case .vitaminE: return "QuantityIdentifierLabel_vitaminE"
            case .vitaminK: return "QuantityIdentifierLabel_vitaminK"
            case .water: return "QuantityIdentifierLabel_water"
            case .zinc: return "QuantityIdentifierLabel_zinc"
            case .food: return "QuantityIdentifierLabel_food"
        }
    }
}
