import Foundation

@objc(MeasurementTransformer)
final class MeasurementTransformer: NSSecureUnarchiveFromDataTransformer {

    /// The name of the transformer. This is what we will use to register the transformer `ValueTransformer.setValueTrandformer(_"forName:)`.
    static let name = NSValueTransformerName(rawValue: String(describing: MeasurementTransformer.self))

    /// Our class `Test` should be in the allowed class list. (This is what the unarchiver uses to check for the right class)
//    override class var allowedTopLevelClasses: [AnyClass] { [NSMeasurement.self] }
    
    override class func transformedValueClass() -> AnyClass { NSMeasurement.self }
    
    override class func allowsReverseTransformation() -> Bool { true }
    
    override func transformedValue(_ value: Any?) -> Any? {
        guard let measure = value as? NSMeasurement else { return nil }
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: measure, requiringSecureCoding: true)
            return data
        } catch {
            assertionFailure("Failed to transform `NSMeasurement` --> `Data`")
            return nil
        }
    }
    
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? NSData else { return nil }
        do {
            let measure = try NSKeyedUnarchiver.unarchivedObject(ofClass: NSMeasurement.self, from: data as Data)
            return measure
        } catch {
            assertionFailure("Failed to transform `Data` --> `NSMeasurement`")
            return nil
        }
    }

}
