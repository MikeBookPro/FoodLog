import Foundation

public enum Nutrient: UInt64, HealthIdentifier {
  case biotin = 0
  case caffeine = 1
  case calcium = 2
  case carbohydrates = 3
  case chloride = 4
  case cholesterol = 5
  case chromium = 6
  case copper = 7
  case energyConsumed = 8
  case fatMonounsaturated = 9
  case fatPolyunsaturated = 10
  case fatSaturated = 11
  case fatTotal = 12
  case fiber = 13
  case folate = 14
  case iodine = 15
  case iron = 16
  case magnesium = 17
  case manganese = 18
  case molybdenum = 19
  case niacin = 20
  case pantothenicAcid = 21
  case phosphorus = 22
  case potassium = 23
  case protein = 24
  case riboflavin = 25
  case selenium = 26
  case sodium = 27
  case sugar = 28
  case thiamin = 29
  case vitaminA = 30
  case vitaminB12 = 31
  case vitaminB6 = 32
  case vitaminC = 33
  case vitaminD = 34
  case vitaminE = 35
  case vitaminK = 36
  case water = 37
  case zinc = 38

  init?(healthKit rawValue: String) { // swiftlint:disable:this cyclomatic_complexity
    switch rawValue {
      case "HKQuantityTypeIdentifierDietaryBiotin": self = .biotin
      case "HKQuantityTypeIdentifierDietaryCaffeine": self = .caffeine
      case "HKQuantityTypeIdentifierDietaryCalcium": self = .calcium
      case "HKQuantityTypeIdentifierDietaryCarbohydrates": self = .carbohydrates
      case "HKQuantityTypeIdentifierDietaryChloride": self = .chloride
      case "HKQuantityTypeIdentifierDietaryCholesterol": self = .cholesterol
      case "HKQuantityTypeIdentifierDietaryChromium": self = .chromium
      case "HKQuantityTypeIdentifierDietaryCopper": self = .copper
      case "HKQuantityTypeIdentifierDietaryEnergyConsumed": self = .energyConsumed
      case "HKQuantityTypeIdentifierDietaryFatMonounsaturated": self = .fatMonounsaturated
      case "HKQuantityTypeIdentifierDietaryFatPolyunsaturated": self = .fatPolyunsaturated
      case "HKQuantityTypeIdentifierDietaryFatSaturated": self = .fatSaturated
      case "HKQuantityTypeIdentifierDietaryFatTotal": self = .fatTotal
      case "HKQuantityTypeIdentifierDietaryFiber": self = .fiber
      case "HKQuantityTypeIdentifierDietaryFolate": self = .folate
      case "HKQuantityTypeIdentifierDietaryIodine": self = .iodine
      case "HKQuantityTypeIdentifierDietaryIron": self = .iron
      case "HKQuantityTypeIdentifierDietaryMagnesium": self = .magnesium
      case "HKQuantityTypeIdentifierDietaryManganese": self = .manganese
      case "HKQuantityTypeIdentifierDietaryMolybdenum": self = .molybdenum
      case "HKQuantityTypeIdentifierDietaryNiacin": self = .niacin
      case "HKQuantityTypeIdentifierDietaryPantothenicAcid": self = .pantothenicAcid
      case "HKQuantityTypeIdentifierDietaryPhosphorus": self = .phosphorus
      case "HKQuantityTypeIdentifierDietaryPotassium": self = .potassium
      case "HKQuantityTypeIdentifierDietaryProtein": self = .protein
      case "HKQuantityTypeIdentifierDietaryRiboflavin": self = .riboflavin
      case "HKQuantityTypeIdentifierDietarySelenium": self = .selenium
      case "HKQuantityTypeIdentifierDietarySodium": self = .sodium
      case "HKQuantityTypeIdentifierDietarySugar": self = .sugar
      case "HKQuantityTypeIdentifierDietaryThiamin": self = .thiamin
      case "HKQuantityTypeIdentifierDietaryVitaminA": self = .vitaminA
      case "HKQuantityTypeIdentifierDietaryVitaminB12": self = .vitaminB12
      case "HKQuantityTypeIdentifierDietaryVitaminB6": self = .vitaminB6
      case "HKQuantityTypeIdentifierDietaryVitaminC": self = .vitaminC
      case "HKQuantityTypeIdentifierDietaryVitaminD": self = .vitaminD
      case "HKQuantityTypeIdentifierDietaryVitaminE": self = .vitaminE
      case "HKQuantityTypeIdentifierDietaryVitaminK": self = .vitaminK
      case "HKQuantityTypeIdentifierDietaryWater": self = .water
      case "HKQuantityTypeIdentifierDietaryZinc": self = .zinc
      default: return nil
    }
  }

  public var option: Self.Option { .init(rawValue: 1 << self.rawValue) }
}

extension Nutrient {
  public struct Option: OptionSet {
    public let rawValue: UInt64

    public init(rawValue: UInt64) {
      self.rawValue = rawValue
    }

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
    static let carbohydrates = Self(rawValue: 1 << 11)
    static let chloride  = Self(rawValue: 1 << 12)
    static let cholesterol = Self(rawValue: 1 << 13)
    static let chromium  = Self(rawValue: 1 << 14)
    static let copper = Self(rawValue: 1 << 15)
    static let energyConsumed = Self(rawValue: 1 << 16)
    static let fatMonounsaturated  = Self(rawValue: 1 << 17)
    static let fatPolyunsaturated  = Self(rawValue: 1 << 18)
    static let fatSaturated = Self(rawValue: 1 << 19)
    static let fatTotal = Self(rawValue: 1 << 20)
    static let fiber = Self(rawValue: 1 << 21)
    static let folate  = Self(rawValue: 1 << 22)
    static let iodine  = Self(rawValue: 1 << 23)
    static let iron = Self(rawValue: 1 << 24)
    static let magnesium  = Self(rawValue: 1 << 25)
    static let manganese  = Self(rawValue: 1 << 26)
    static let molybdenum = Self(rawValue: 1 << 27)
    static let niacin = Self(rawValue: 1 << 28)
    static let pantothenicAcid = Self(rawValue: 1 << 29)
    static let phosphorus = Self(rawValue: 1 << 30)
    static let potassium = Self(rawValue: 1 << 31)
    static let protein = Self(rawValue: 1 << 32)
    static let riboflavin = Self(rawValue: 1 << 33)
    static let selenium = Self(rawValue: 1 << 34)
    static let sodium = Self(rawValue: 1 << 35)
    static let sugar = Self(rawValue: 1 << 36)
    static let thiamin = Self(rawValue: 1 << 37)
    static let vitaminA = Self(rawValue: 1 << 38)
    static let vitaminB12 = Self(rawValue: 1 << 39)
    static let vitaminB6 = Self(rawValue: 1 << 40)
    static let vitaminC  = Self(rawValue: 1 << 41)
    static let vitaminD  = Self(rawValue: 1 << 42)
    static let vitaminE  = Self(rawValue: 1 << 43)
    static let vitaminK  = Self(rawValue: 1 << 44)
    static let water = Self(rawValue: 1 << 45)
    static let zinc  = Self(rawValue: 1 << 46)
  }
}
