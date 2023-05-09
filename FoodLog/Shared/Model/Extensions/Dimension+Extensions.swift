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
