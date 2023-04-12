import Foundation

public typealias DateRange = (start: Date?, end: Date?)

public protocol DateRangeReadable {
    var dateRange: DateRange { get }
}

public protocol SampledMeasurement: IdentifiableMeasurement, DateRangeReadable {
    associatedtype IdentifiedMeasure: IdentifiableMeasurementInitializable where Identifier == IdentifiedMeasure.Identifier, UnitType == IdentifiedMeasure.UnitType
}

public protocol SampledMeasurementInititializable: SampledMeasurement {
    init(quantity: IdentifiedMeasure, dateRange: DateRange)
}

struct MeasurementSample<IdentifiedMeasure: IdentifiableMeasurementInitializable>: SampledMeasurementInititializable {
    let dateRange: DateRange
    let identifier: IdentifiedMeasure.Identifier
    var measurement: Measurement<IdentifiedMeasure.UnitType>
    
    init(quantity: IdentifiedMeasure, dateRange: DateRange = (nil, nil))  {
        self.dateRange = dateRange
        self.identifier = quantity.identifier
        self.measurement = quantity.measurement
    }
    
    
}
