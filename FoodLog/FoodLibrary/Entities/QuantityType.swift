import Foundation
import HealthKit

// MARK: - Quantity Type

public protocol QuantityIdentifier: Identifiable {
    static var baseIdentifier: () -> Self { get }
    
    var id: String { get }
}

public protocol QuantityIdentifierInitializable: QuantityIdentifier {
    init?(rawValue: String)
}

enum BodyMeasurementQuantityType: String, QuantityIdentifierInitializable {
    case height = "HKQuantityTypeIdentifierHeight"
    case bodyMass = "HKQuantityTypeIdentifierBodyMass"
    case leanBodyMass = "HKQuantityTypeIdentifierLeanBodyMass"
    case bodyFatPercentage = "HKQuantityTypeIdentifierBodyFatPercentage"
    case waistCircumference = "HKQuantityTypeIdentifierWaistCircumference"
    
    var id: String { self.rawValue }
    
    static let baseIdentifier: () -> Self = { .bodyMass }
    
}
