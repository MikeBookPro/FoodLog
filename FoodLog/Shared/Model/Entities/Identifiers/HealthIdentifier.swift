import Foundation

protocol HealthIdentifier {
  associatedtype Option: OptionSet where Option.RawValue == UInt64
  var option: Option { get }

  init?(healthKit rawValue: String)
}
