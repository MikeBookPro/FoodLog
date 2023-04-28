import Foundation

enum IdentifierToOptionAdapter: MappedAdapter {
    typealias Source = QuantityIdentifier
    typealias Destination = QuantityIdentifierOption
    
    static func value(mappedTo source: QuantityIdentifier) -> QuantityIdentifierOption {
        switch source {
            case .unknown: return .unknown
            case .height: return .height
            case .bodyMass: return .bodyMass
            case .leanBodyMass: return .leanBodyMass
            case .bodyFatPercentage: return .bodyFatPercentage
            case .waistCircumference: return .waistCircumference
            case .bloodGlucose: return .bloodGlucose
            case .servingSize: return .servingSize
        }
    }
}

enum IdentifierDimension {
    static let prefersKilograms: QuantityIdentifierOption = [.bodyMass, .leanBodyMass]
    static let prefersCentimeters: QuantityIdentifierOption = [.height, .waistCircumference]
    static let prefersPercent: QuantityIdentifierOption = [.bodyFatPercentage]
}



enum QuantityIdentifierToDimensionAdapter<UnitType: Dimension>: MappedAdapter {
    typealias Source = QuantityIdentifier
    typealias Destination = UnitType
    
    private static func preferredUnit(forSelected option: QuantityIdentifierOption) -> Destination {
        let prefersKilograms: QuantityIdentifierOption = [.bodyMass, .leanBodyMass]
        let prefersCentimeters: QuantityIdentifierOption = [.height, .waistCircumference]
        let prefersPercent: QuantityIdentifierOption = [.bodyFatPercentage]
        
        var unit: Dimension = UnitUnknown.unknown
        
        if prefersKilograms.contains(option) { unit = UnitMass.kilograms }
        if prefersCentimeters.contains(option) { unit = UnitLength.centimeters }
        if prefersPercent.contains(option) { unit = UnitCount.percent }
        
        return unit as? Destination ?? Destination.baseUnit()
    }
    
    static func value(mappedTo source: Source) -> Destination {
        let option = IdentifierToOptionAdapter.value(mappedTo: source)
        return preferredUnit(forSelected: option)
    }
}

enum IdentifierToDimensionAdapter: MappedAdapter {
    private static func preferredUnit(forSelected option: QuantityIdentifierOption) -> Dimension {
        if IdentifierDimension.prefersKilograms.contains(option) { return UnitMass.kilograms }
        if IdentifierDimension.prefersCentimeters.contains(option) { return UnitLength.centimeters }
        if IdentifierDimension.prefersPercent.contains(option) { return UnitCount.percent }
        return UnitUnknown.unknown
    }
    
    
    static func value(mappedTo source: QuantityIdentifier) -> Dimension {
        let option = IdentifierToOptionAdapter.value(mappedTo: source)
        return preferredUnit(forSelected: option)
    }
}
