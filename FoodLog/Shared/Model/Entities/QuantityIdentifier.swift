import Foundation

public enum QuantityIdentifier: String, Identifiable, CaseIterable {
    case unknown
    case height = "HKQuantityTypeIdentifierHeight"
    case bodyMass = "HKQuantityTypeIdentifierBodyMass"
    case leanBodyMass = "HKQuantityTypeIdentifierLeanBodyMass"
    case bodyFatPercentage = "HKQuantityTypeIdentifierBodyFatPercentage"
    case waistCircumference = "HKQuantityTypeIdentifierWaistCircumference"
    
    // Health Measurement
    case bloodGlucose = "HKQuantityTypeIdentifierBloodGlucose"
    
    // Dietary Nutrition
    case servingSize = "NotHKQuantityTypeIdentifier-ServingSize"
    
//    case unknown
//    case height = "HKQuantityTypeIdentifierHeight"
//    case bodyMass = "HKQuantityTypeIdentifierBodyMass"
//    case leanBodyMass = "HKQuantityTypeIdentifierLeanBodyMass"
//    case bodyFatPercentage = "HKQuantityTypeIdentifierBodyFatPercentage"
//    case waistCircumference = "HKQuantityTypeIdentifierWaistCircumference"
//    case bloodGlucose = "HKQuantityTypeIdentifierBloodGlucose"
//    case servingSize = "NotHKQuantityTypeIdentifier-ServingSize"
    case biotin = "HKQuantityTypeIdentifierDietaryBiotin"
    case caffeine = "HKQuantityTypeIdentifierDietaryCaffeine"
    case calcium = "HKQuantityTypeIdentifierDietaryCalcium"
    case carbohydrates = "HKQuantityTypeIdentifierDietaryCarbohydrates"
    case chloride = "HKQuantityTypeIdentifierDietaryChloride"
    case cholesterol = "HKQuantityTypeIdentifierDietaryCholesterol"
    case chromium = "HKQuantityTypeIdentifierDietaryChromium"
    case copper = "HKQuantityTypeIdentifierDietaryCopper"
    case energyConsumed = "HKQuantityTypeIdentifierDietaryEnergyConsumed"
    case fatMonounsaturated = "HKQuantityTypeIdentifierDietaryFatMonounsaturated"
    case fatPolyunsaturated = "HKQuantityTypeIdentifierDietaryFatPolyunsaturated"
    case fatSaturated = "HKQuantityTypeIdentifierDietaryFatSaturated"
    case fatTotal = "HKQuantityTypeIdentifierDietaryFatTotal"
    case fiber = "HKQuantityTypeIdentifierDietaryFiber"
    case folate = "HKQuantityTypeIdentifierDietaryFolate"
    case iodine = "HKQuantityTypeIdentifierDietaryIodine"
    case iron = "HKQuantityTypeIdentifierDietaryIron"
    case magnesium = "HKQuantityTypeIdentifierDietaryMagnesium"
    case manganese = "HKQuantityTypeIdentifierDietaryManganese"
    case molybdenum = "HKQuantityTypeIdentifierDietaryMolybdenum"
    case niacin = "HKQuantityTypeIdentifierDietaryNiacin"
    case pantothenicAcid = "HKQuantityTypeIdentifierDietaryPantothenicAcid"
    case phosphorus = "HKQuantityTypeIdentifierDietaryPhosphorus"
    case potassium = "HKQuantityTypeIdentifierDietaryPotassium"
    case protein = "HKQuantityTypeIdentifierDietaryProtein"
    case riboflavin = "HKQuantityTypeIdentifierDietaryRiboflavin"
    case selenium = "HKQuantityTypeIdentifierDietarySelenium"
    case sodium = "HKQuantityTypeIdentifierDietarySodium"
    case sugar = "HKQuantityTypeIdentifierDietarySugar"
    case thiamin = "HKQuantityTypeIdentifierDietaryThiamin"
    case vitaminA = "HKQuantityTypeIdentifierDietaryVitaminA"
    case vitaminB12 = "HKQuantityTypeIdentifierDietaryVitaminB12"
    case vitaminB6 = "HKQuantityTypeIdentifierDietaryVitaminB6"
    case vitaminC = "HKQuantityTypeIdentifierDietaryVitaminC"
    case vitaminD = "HKQuantityTypeIdentifierDietaryVitaminD"
    case vitaminE = "HKQuantityTypeIdentifierDietaryVitaminE"
    case vitaminK = "HKQuantityTypeIdentifierDietaryVitaminK"
    case water = "HKQuantityTypeIdentifierDietaryWater"
    case zinc = "HKQuantityTypeIdentifierDietaryZinc"
    
    // Characteristic Type
//    case biologicalSex = "HKCharacteristicTypeIdentifierBiologicalSex
//    case dateOfBirth = "HKCharacteristicTypeIdentifierDateOfBirth
    
    // Correlation Type
    case food = "HKCorrelationTypeIdentifierFood"
    
    
    public var id: String { self.rawValue }
    
    public var isHealthKitIdentifier: Bool { self != .servingSize && self != .unknown }
    
    init(string: String?) {
        var identifier = Self.unknown
        if let string, let valid = Self(rawValue: string) {
            identifier = valid
        }
        self = identifier
    }
}

struct QuantityIdentifierOption: OptionSet {
    let rawValue: Int64
    
    static let unknown = Self(rawValue: 1 << 0)
    static let height = Self(rawValue: 1 << 1)
    static let bodyMass = Self(rawValue: 1 << 2)
    static let leanBodyMass = Self(rawValue: 1 << 3)
    static let bodyFatPercentage = Self(rawValue: 1 << 4)
    static let waistCircumference = Self(rawValue: 1 << 5)
    static let bloodGlucose = Self(rawValue: 1 << 6)
    static let servingSize = Self(rawValue: 1 << 7)
    static let biotin = Self(rawValue: 1 << 8)
    static let caffeine = Self(rawValue: 1 << 9)
    static let calcium  = Self(rawValue: 1 << 10)
    static let carbohydrates  = Self(rawValue: 1 << 11)
    static let chloride  = Self(rawValue: 1 << 12)
    static let cholesterol  = Self(rawValue: 1 << 13)
    static let chromium  = Self(rawValue: 1 << 14)
    static let copper  = Self(rawValue: 1 << 15)
    static let energyConsumed  = Self(rawValue: 1 << 16)
    static let fatMonounsaturated  = Self(rawValue: 1 << 17)
    static let fatPolyunsaturated  = Self(rawValue: 1 << 18)
    static let fatSaturated  = Self(rawValue: 1 << 19)
    static let fatTotal  = Self(rawValue: 1 << 20)
    static let fiber  = Self(rawValue: 1 << 21)
    static let folate  = Self(rawValue: 1 << 22)
    static let iodine  = Self(rawValue: 1 << 23)
    static let iron  = Self(rawValue: 1 << 24)
    static let magnesium  = Self(rawValue: 1 << 25)
    static let manganese  = Self(rawValue: 1 << 26)
    static let molybdenum  = Self(rawValue: 1 << 27)
    static let niacin  = Self(rawValue: 1 << 28)
    static let pantothenicAcid  = Self(rawValue: 1 << 29)
    static let phosphorus  = Self(rawValue: 1 << 30)
    static let potassium  = Self(rawValue: 1 << 31)
    static let protein  = Self(rawValue: 1 << 32)
    static let riboflavin  = Self(rawValue: 1 << 33)
    static let selenium  = Self(rawValue: 1 << 34)
    static let sodium  = Self(rawValue: 1 << 35)
    static let sugar  = Self(rawValue: 1 << 36)
    static let thiamin  = Self(rawValue: 1 << 37)
    static let vitaminA  = Self(rawValue: 1 << 38)
    static let vitaminB12  = Self(rawValue: 1 << 39)
    static let vitaminB6  = Self(rawValue: 1 << 40)
    static let vitaminC  = Self(rawValue: 1 << 41)
    static let vitaminD  = Self(rawValue: 1 << 42)
    static let vitaminE  = Self(rawValue: 1 << 43)
    static let vitaminK  = Self(rawValue: 1 << 44)
    static let water  = Self(rawValue: 1 << 45)
    static let zinc  = Self(rawValue: 1 << 46)
    
    static let food  = Self(rawValue: 1 << 64)
}
