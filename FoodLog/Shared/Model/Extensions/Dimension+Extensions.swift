import Foundation

// MARK: - Count

/// Custom subclass of Dimension
final class UnitCount: Dimension {
  static let integer = UnitCount(symbol: "events", converter: UnitConverterLinear(coefficient: 1.0))
  static let percent = UnitCount(symbol: "%", converter: UnitConverterLinear(coefficient: 100.0))

  //    static let baseUnit = UnitCount.integer

  override class func baseUnit() -> Self {
    UnitCount.integer as! Self // swiftlint:disable:this force_cast
  }
}

// MARK: - Pharmacology

/// Returns a HealthKit unit that measures the amount of a biologically active substance in international units (IU).
final class UnitPharmacology: Dimension {
  static let internationalUnit = UnitPharmacology(symbol: "IU", converter: UnitConverterLinear(coefficient: 1.0))

  //    static let baseUnit = UnitCount.integer

  override class func baseUnit() -> Self {
    UnitPharmacology.internationalUnit as! Self // swiftlint:disable:this force_cast
  }
}

// MARK: - Unknown

final class UnitUnknown: Dimension {
  static let unknown = UnitUnknown(symbol: "--", converter: UnitConverterLinear(coefficient: .zero))

  override class func baseUnit() -> Self {
    UnitUnknown.unknown as! Self // swiftlint:disable:this force_cast
  }
}

extension Dimension {
  //    static var empty: Measurement<Dimension> { Measurement(value: .zero, unit: Self.baseUnit()) }
  var empty: Measurement<Dimension> { Measurement(value: .zero, unit: self) }

  static let massDimensions: [UnitMass] = [
    .micrograms,
    .milligrams,
    .grams,
    .kilograms,
    .metricTons,
    .ounces,
    .pounds,
  ]

  static let lengthDimensions: [UnitLength] = [
    .kilometers,
    .meters,
    .centimeters,
    .millimeters,
    .inches,
    .feet,
    .yards,
    .miles,
  ]

  static let volumeDimensions: [UnitVolume] = [
    .liters,
    .milliliters,
    .cubicKilometers,
    .teaspoons,
    .tablespoons,
    .fluidOunces,
    .cups,
    .pints,
    .quarts,
    .gallons,
  ]
}

extension Dimension: Identifiable {
  public var id: String { self.symbol }
}
