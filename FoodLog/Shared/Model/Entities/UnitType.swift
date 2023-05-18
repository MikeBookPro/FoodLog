import Foundation

enum UnitType: String, CaseIterable, Identifiable {
    case mass = "Mass"
    case length = "Length"
    case volume = "Volume"
    //... Add more as needed
    
    init(unit: Dimension) {
        if Dimension.massDimensions.contains(where: { $0.isEqual(unit) }) {
            self = .mass
        } else if Dimension.lengthDimensions.contains(where: { $0.isEqual(unit) }) {
            self = .length
        } else if Dimension.volumeDimensions.contains(where: { $0.isEqual(unit) }) {
            self = .volume
        } else {
            self = .mass
            
        }
    }
    
    var dimensions: [Dimension] {
        switch self {
            case .mass: return Dimension.massDimensions
            case .length: return Dimension.lengthDimensions
            case .volume: return Dimension.volumeDimensions
        }
    }
    
    var baseUnit: Dimension {
        switch self {
            case .mass: return UnitMass.baseUnit()
            case .length: return UnitLength.baseUnit()
            case .volume: return UnitVolume.baseUnit()
        }
    }
    
    var id: String { self.baseUnit.symbol }
}
