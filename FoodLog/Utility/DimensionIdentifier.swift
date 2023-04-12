import Foundation

enum DimensionIdentifier {
    case mass
    case length
    case energy
    
    init?(baseUnitSymbol: String?) {
        guard let baseUnitSymbol else { return nil }
        switch baseUnitSymbol {
            case UnitMass.baseUnit().symbol: self = .mass
            case UnitLength.baseUnit().symbol: self = .length
            case UnitEnergy.baseUnit().symbol: self = .energy
            default: return nil
        }
    }
}

enum DimensionUnitInterpreter {
    static func baseUnit(for sample: some SampledMeasurement) -> String {
        type(of: (sample.measurement.unit as Dimension)).baseUnit().symbol
    }
}

enum MeasurementFactory {
    
    static func dimension(for identifier: DimensionIdentifier) -> Dimension.Type {
        switch identifier {
            case .mass: return UnitMass.self
            case .length: return UnitLength.self
            case .energy: return UnitEnergy.self
        }
    }
    
    static func measurement(forDimension identifier: DimensionIdentifier, value: Double) -> Measurement<Dimension> {
        .init(value: value, unit: Self.dimension(for: identifier).baseUnit())
    }
}
