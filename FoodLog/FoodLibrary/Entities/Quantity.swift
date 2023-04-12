import Foundation
//
//// MARK: - Quantity
//
//public protocol QuantityReadable {
//    associatedtype UnitType: Unit
//    var value: Double { get }
//    var unit: UnitType { get }
//}
//
//public protocol QuantityRepresentable: QuantityReadable {
//
//    init(value: Double, unit: UnitType)
//}
//
//public struct Quantity<UnitType: Unit>: QuantityRepresentable {
//    public let value: Double
//    public let unit: UnitType
//
//    public init(value: Double, unit: UnitType) {
//        self.value = value
//        self.unit = unit
//    }
//}
//

//public final class QuantityObject: NSSecureUnarchiveFromDataTransformer, NSSecureCoding, QuantityRepresentable {
//    public let value: Double
//    public let unit: Unit
//
//    public init(value: Double, unit: Unit) {
//        self.value = value
//        self.unit = unit
//    }
//
//    private enum CodingKeys: String, CodingKey { case value, unit }
//
//    public static var supportsSecureCoding: Bool = true
//
//    public func encode(with coder: NSCoder) {
//        coder.encode(value, forKey: CodingKeys.value.rawValue)
//        coder.encode(unit, forKey: CodingKeys.unit.rawValue)
//    }
//
//    public init?(coder: NSCoder) {
//        self.value = coder.decodeDouble(forKey: CodingKeys.value.rawValue)
//        self.unit = coder.decodeObject(forKey: CodingKeys.unit.rawValue) as! Unit
//    }
//}
//
//@objc(QuantityObjectTransformer)
//final class QuantityObjectTransformer: NSSecureUnarchiveFromDataTransformer {
//
//    /// The name of the transformer. This is what we will use to register the transformer `ValueTransformer.setValueTrandformer(_"forName:)`.
//    static let name = NSValueTransformerName(rawValue: String(describing: QuantityObjectTransformer.self))
//
//    /// Our class `Test` should be in the allowed class list. (This is what the unarchiver uses to check for the right class)
//    override class var allowedTopLevelClasses: [AnyClass] { [QuantityObject.self] }
//
//}
//
//
//
//

//
//
//
//
//
// MARK: - Quantity Sample

public typealias DateRange = (start: Date?, end: Date?)

public protocol DateRangeReadable {
    var dateRange: DateRange { get }
}

public protocol SampledMeasureInititializable: IdentifiableMeasurement, DateRangeReadable {
    init(
        measurement: some IdentifiableMeasurement,
        dateRange: DateRange
    )
}
