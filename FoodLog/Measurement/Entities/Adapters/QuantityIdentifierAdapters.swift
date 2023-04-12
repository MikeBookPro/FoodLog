import Foundation

enum QuantityIdentifierToIdentifierOptionAdapter: MappedAdapter {
    typealias Source = QuantityIdentifier
    typealias Destination = QuantityIdentifierOption
    
    private static let destinationValues: [Source: Destination] = [
        .height: .height,
        .bodyMass: .bodyMass,
        .leanBodyMass: .leanBodyMass,
        .bodyFatPercentage: .bodyFatPercentage,
        .waistCircumference: .waistCircumference,
    ]
    
    static func value(mappedTo source: Source) -> Destination {
        return destinationValues[source] ?? .unknown
    }
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
        let identifierOption = QuantityIdentifierToIdentifierOptionAdapter.value(mappedTo: source)
        return preferredUnit(forSelected: identifierOption)
    }
}
