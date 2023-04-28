import Foundation

public enum QuantityIdentifier: String, Identifiable, CaseIterable {
    case height = "HKQuantityTypeIdentifierHeight"
    case bodyMass = "HKQuantityTypeIdentifierBodyMass"
    case leanBodyMass = "HKQuantityTypeIdentifierLeanBodyMass"
    case bodyFatPercentage = "HKQuantityTypeIdentifierBodyFatPercentage"
    case waistCircumference = "HKQuantityTypeIdentifierWaistCircumference"
    
    // TODO: Add Nutrients here
    
    public var id: String { self.rawValue }
    
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


