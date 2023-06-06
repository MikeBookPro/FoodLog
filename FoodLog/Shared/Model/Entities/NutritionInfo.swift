import Foundation

struct NutritionInfo {
  var servingSize: Measurement<Dimension>
  var nutrientMeasurements: [HealthMeasurement<Nutrient>]
  var scannedLabel: ScannedLabel?

  init(servingSize: Measurement<Dimension>, nutrientMeasurements: [HealthMeasurement<Nutrient>]) {
    self.servingSize = servingSize
    self.nutrientMeasurements = nutrientMeasurements
  }
}
