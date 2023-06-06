import Foundation

struct HealthMeasurement<HealthID: HealthIdentifier>: Identifiable {
  let id: UUID
  let healthID: HealthID
  var measurement: Measurement<Dimension>
  var dimension: Dimension {
    get { measurement.unit }
    set { measurement = .init(value: measurement.value, unit: newValue)}
  }

  init(_ healthID: HealthID, measurement: Measurement<Dimension>, id: UUID? = nil) {
    self.healthID = healthID
    self.measurement = measurement
    self.id = id ?? .init()
  }
}
