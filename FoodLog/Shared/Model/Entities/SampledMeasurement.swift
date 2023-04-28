import Foundation

public protocol SampledMeasurement: IdentifiableMeasurement {
    associatedtype IdentifiedMeasure: IdentifiableMeasurement where UnitType == IdentifiedMeasure.UnitType
    
    var date: Date { get }
    
    init(quantity: IdentifiedMeasure, date: Date)
}

struct MeasurementSample<IdentifiedMeasure: IdentifiableMeasurement>: SampledMeasurement {
    let id: UUID?
    let identifier: QuantityIdentifier
    let measurement: Measurement<IdentifiedMeasure.UnitType>
    let date: Date
    
    init(quantity: IdentifiedMeasure, date: Date = .now)  {
        self.init(identifier: quantity.identifier, measurement: quantity.measurement, existingID: quantity.id)
    }
    
    init(identifier: QuantityIdentifier, measurement: Measurement<IdentifiedMeasure.UnitType>, existingID: UUID?) {
        self.id = existingID
        self.identifier = identifier
        self.measurement = measurement
        self.date = .now
    }
}
