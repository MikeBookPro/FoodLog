import Foundation

public enum Biometric: UInt64, HealthIdentifier {
  case height = 1
  case bodyMass = 2
  case leanBodyMass = 3
  case bodyFatPercentage = 4
  case waistCircumference = 5
  case bloodGlucose = 6

  init?(healthKit rawValue: String) {
    switch rawValue {
      case "HKQuantityTypeIdentifierHeight": self = .height
      case "HKQuantityTypeIdentifierBodyMass": self = .bodyMass
      case "HKQuantityTypeIdentifierLeanBodyMass": self = .leanBodyMass
      case "HKQuantityTypeIdentifierBodyFatPercentage": self = .bodyFatPercentage
      case "HKQuantityTypeIdentifierWaistCircumference": self = .waistCircumference
      case "HKQuantityTypeIdentifierBloodGlucose": self = .bloodGlucose
      default: return nil
    }
  }

  public var option: Self.Option { .init(rawValue: 1 << self.rawValue) }
}

extension Biometric {
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
  }
}
