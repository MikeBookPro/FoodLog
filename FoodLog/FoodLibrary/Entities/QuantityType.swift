import Foundation
import HealthKit

// MARK: - Quantity Type

public protocol QuantityTypeReadable: Identifiable {
    var id: String { get }
}

public protocol QuantityTypeRepresentable: QuantityTypeReadable {
    init?(rawValue: String)
}

enum BodyMeasurementQuantityType: String, QuantityTypeRepresentable {
    case height = "HKQuantityTypeIdentifierHeight"
    case bodyMass = "HKQuantityTypeIdentifierBodyMass"
    case leanBodyMass = "HKQuantityTypeIdentifierLeanBodyMass"
    case bodyFatPercentage = "HKQuantityTypeIdentifierBodyFatPercentage"
    case waistCircumference = "HKQuantityTypeIdentifierWaistCircumference"
    
    var id: String { self.rawValue }
    
}
