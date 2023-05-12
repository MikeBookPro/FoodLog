import Foundation


// MARK: - Count

/// Custom subclass of Dimension
class UnitCount: Dimension {
    static let integer = UnitCount(symbol: "events", converter: UnitConverterLinear(coefficient: 1.0))
    static let percent = UnitCount(symbol: "%", converter: UnitConverterLinear(coefficient: 100.0))
    
//    static let baseUnit = UnitCount.integer
    
    override class func baseUnit() -> Self {
        UnitCount.integer as! Self
    }
}

// MARK: - Pharmacology

/// Returns a HealthKit unit that measures the amount of a biologically active substance in international units (IU).
class UnitPharmacology: Dimension {
    static let internationalUnit = UnitPharmacology(symbol: "IU", converter: UnitConverterLinear(coefficient: 1.0))
    
//    static let baseUnit = UnitCount.integer
    
    override class func baseUnit() -> Self {
        UnitPharmacology.internationalUnit as! Self
    }
}

// MARK: - Unknown

class UnitUnknown: Dimension {
    static let unknown = UnitUnknown(symbol: "--", converter: UnitConverterLinear(coefficient: .zero))
    
    override class func baseUnit() -> Self {
        UnitUnknown.unknown as! Self
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
//        .shortTons,
//        .carats,
        .ounces,
        .pounds,
//        .stones,
//        .slugs
    ]
    
    static let lengthDimensions: [UnitLength] = [
//        .megameters,
        .kilometers,
//        .hectometers,
//        .decameters,
        .meters,
//        .decimeters,
        .centimeters,
        .millimeters,
//        .micrometers,
//        .nanometers,
//        .picometers,
        .inches,
        .feet,
        .yards,
        .miles,
        .scandinavianMiles,
//        .lightyears,
//        .nauticalMiles,
//        .fathoms,
//        .furlongs,
//        .astronomicalUnits,
//        .parsecs
    ]
    
    static let volumeDimensions: [UnitVolume] = [
//        .megaliters,
//        .kiloliters,
        .liters,
//        .deciliters,
//        .centiliters,
        .milliliters,
        .cubicKilometers,
//        .cubicMeters,
//        .cubicDecimeters,
//        .cubicCentimeters,
//        .cubicMillimeters,
//        .cubicInches,
//        .cubicFeet,
//        .cubicYards,
//        .cubicMiles,
//        .acreFeet,
//        .bushels,
        .teaspoons,
        .tablespoons,
        .fluidOunces,
        .cups,
        .pints,
        .quarts,
        .gallons,
//        .imperialTeaspoons,
//        .imperialTablespoons,
//        .imperialFluidOunces,
//        .imperialPints,
//        .imperialQuarts,
//        .imperialGallons,
//        .metricCups
    ]

}
