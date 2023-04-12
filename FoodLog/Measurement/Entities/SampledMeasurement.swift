import Foundation

public protocol SampledMeasurement: IdentifiableMeasurement, DateRangeReadable {
    associatedtype IdentifiedMeasure: IdentifiableMeasurement where UnitType == IdentifiedMeasure.UnitType
    
    var dateRange: DateRange { get }
    
    init(quantity: IdentifiedMeasure, dateRange: DateRange)
}

struct MeasurementSample<IdentifiedMeasure: IdentifiableMeasurement>: SampledMeasurement {
    let id: UUID
    let identifier: QuantityIdentifier
    let measurement: Measurement<IdentifiedMeasure.UnitType>
    let dateRange: DateRange
    
    init(quantity: IdentifiedMeasure, dateRange: DateRange = (nil, nil))  {
        self.init(identifier: quantity.identifier, measurement: quantity.measurement, existingID: quantity.id)
    }
    
    init(identifier: QuantityIdentifier, measurement: Measurement<IdentifiedMeasure.UnitType>, existingID: UUID?) {
        self.id = existingID ?? UUID()
        self.identifier = identifier
        self.measurement = measurement
        self.dateRange = (nil, nil)
    }
}
