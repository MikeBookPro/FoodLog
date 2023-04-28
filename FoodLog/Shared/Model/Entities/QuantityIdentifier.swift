import Foundation

public enum QuantityIdentifier: String, Identifiable, CaseIterable {
    case height = "HKQuantityTypeIdentifierHeight"
    case bodyMass = "HKQuantityTypeIdentifierBodyMass"
    case leanBodyMass = "HKQuantityTypeIdentifierLeanBodyMass"
    case bodyFatPercentage = "HKQuantityTypeIdentifierBodyFatPercentage"
    case waistCircumference = "HKQuantityTypeIdentifierWaistCircumference"
    
    // Health Measurement
    case bloodGlucose = "HKQuantityTypeIdentifierBloodGlucose"
    
    // Dietary Nutrition
    case servingSize = "NotHKQuantityTypeIdentifier-ServingSize"
    
//    case biotin = "HKQuantityTypeIdentifierDietaryBiotin"
//    case caffeine = "HKQuantityTypeIdentifierDietaryCaffeine"
//    case calcium = "HKQuantityTypeIdentifierDietaryCalcium"
//    case carbohydrates = "HKQuantityTypeIdentifierDietaryCarbohydrates"
//    case chloride = "HKQuantityTypeIdentifierDietaryChloride"
//    case cholesterol = "HKQuantityTypeIdentifierDietaryCholesterol"
//    case chromium = "HKQuantityTypeIdentifierDietaryChromium"
//    case copper = "HKQuantityTypeIdentifierDietaryCopper"
//    case energyConsumed = "HKQuantityTypeIdentifierDietaryEnergyConsumed"
//    case fatMonounsaturated = "HKQuantityTypeIdentifierDietaryFatMonounsaturated"
//    case fatPolyunsaturated = "HKQuantityTypeIdentifierDietaryFatPolyunsaturated"
//    case fatSaturated = "HKQuantityTypeIdentifierDietaryFatSaturated"
//    case fatTotal = "HKQuantityTypeIdentifierDietaryFatTotal"
//    case fiber = "HKQuantityTypeIdentifierDietaryFiber"
//    case folate = "HKQuantityTypeIdentifierDietaryFolate"
//    case iodine = "HKQuantityTypeIdentifierDietaryIodine"
//    case iron = "HKQuantityTypeIdentifierDietaryIron"
//    case magnesium = "HKQuantityTypeIdentifierDietaryMagnesium"
//    case manganese = "HKQuantityTypeIdentifierDietaryManganese"
//    case molybdenum = "HKQuantityTypeIdentifierDietaryMolybdenum"
//    case niacin = "HKQuantityTypeIdentifierDietaryNiacin"
//    case pantothenicAcid = "HKQuantityTypeIdentifierDietaryPantothenicAcid"
//    case phosphorus = "HKQuantityTypeIdentifierDietaryPhosphorus"
//    case potassium = "HKQuantityTypeIdentifierDietaryPotassium"
//    case protein = "HKQuantityTypeIdentifierDietaryProtein"
//    case riboflavin = "HKQuantityTypeIdentifierDietaryRiboflavin"
//    case selenium = "HKQuantityTypeIdentifierDietarySelenium"
//    case sodium = "HKQuantityTypeIdentifierDietarySodium"
//    case sugar = "HKQuantityTypeIdentifierDietarySugar"
//    case thiamin = "HKQuantityTypeIdentifierDietaryThiamin"
//    case vitaminA = "HKQuantityTypeIdentifierDietaryVitaminA"
//    case vitaminB12 = "HKQuantityTypeIdentifierDietaryVitaminB12"
//    case vitaminB6 = "HKQuantityTypeIdentifierDietaryVitaminB6"
//    case vitaminC = "HKQuantityTypeIdentifierDietaryVitaminC"
//    case vitaminD = "HKQuantityTypeIdentifierDietaryVitaminD"
//    case vitaminE = "HKQuantityTypeIdentifierDietaryVitaminE"
//    case vitaminK = "HKQuantityTypeIdentifierDietaryVitaminK"
//    case water = "HKQuantityTypeIdentifierDietaryWater"
//    case zinc = "HKQuantityTypeIdentifierDietaryZinc"
    
    // Characteristic Type
//    case biologicalSex = "HKCharacteristicTypeIdentifierBiologicalSex
//    case dateOfBirth = "HKCharacteristicTypeIdentifierDateOfBirth
    
    // Correlation Type
//    case food = "HKCorrelationTypeIdentifierFood"
    
    
    public var id: String { self.rawValue }
    
    public var isHealthKitIdentifier: Bool { self != .servingSize }
    
    init?(string: String?) {
        guard let string else { return nil }
        self.init(rawValue: string)
    }
}


struct QuantityIdentifierOption: OptionSet {
    let rawValue: Int
    static let unknown = Self(rawValue: 1 << 0)
    
    static let height = Self(rawValue: 1 << 1)
    static let bodyMass = Self(rawValue: 1 << 2)
    static let leanBodyMass = Self(rawValue: 1 << 3)
    static let bodyFatPercentage = Self(rawValue: 1 << 4)
    static let waistCircumference = Self(rawValue: 1 << 5)
    
    // TODO: Add Nutrients here
}


