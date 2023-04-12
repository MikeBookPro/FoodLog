import Foundation

public protocol SampledMeasurement: IdentifiableMeasurement, DateRangeReadable {
    associatedtype IdentifiedMeasure: IdentifiableMeasurement where UnitType == IdentifiedMeasure.UnitType
    
    var dateRange: DateRange { get }
    
    init(quantity: IdentifiedMeasure, dateRange: DateRange)
}

struct MeasurementSample<IdentifiedMeasure: IdentifiableMeasurement>: SampledMeasurement {
    let dateRange: DateRange
    let identifier: QuantityIdentifier
    var measurement: Measurement<IdentifiedMeasure.UnitType>
    
    init(quantity: IdentifiedMeasure, dateRange: DateRange = (nil, nil))  {
        self.dateRange = dateRange
        self.identifier = quantity.identifier
        self.measurement = quantity.measurement
    }
    
    init(identifier: QuantityIdentifier, measurement: Measurement<IdentifiedMeasure.UnitType>) {
        self.dateRange = (nil, nil)
        self.identifier = identifier
        self.measurement = measurement
    }
}
