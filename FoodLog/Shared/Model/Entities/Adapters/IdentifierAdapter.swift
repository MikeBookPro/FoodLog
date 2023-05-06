import Foundation

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
}

enum IdentifierToDimensionAdapter: Adapter {
    private static func preferredUnit(forSelected option: QuantityIdentifierOption) -> Dimension {
        if IdentifierDimension.prefersKilograms.contains(option) { return UnitMass.kilograms }
        if IdentifierDimension.prefersCentimeters.contains(option) { return UnitLength.centimeters }
        if IdentifierDimension.prefersPercent.contains(option) { return UnitCount.percent }
        return UnitUnknown.unknown
    }
    
    
    static func value(mappedTo source: QuantityIdentifier) -> Dimension {
        let option = IdentifierToOptionAdapter.value(mappedTo: source)
        return preferredUnit(forSelected: option)
    }
}
