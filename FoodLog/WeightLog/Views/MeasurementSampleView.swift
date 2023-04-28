//

import SwiftUI

struct MeasurementSampleView<Sample: SampledMeasurement>: View {
    @Binding var isShowingEditor: Bool
    private let id: UUID?
    private let identifier: QuantityIdentifier
    private let measurement: Measurement<Sample.UnitType>
    private let date: Date
    
    init(sample: Sample, editorToggle isShowingEditor: Binding<Bool>) {
        self._isShowingEditor = isShowingEditor
        self.id = sample.id
        self.identifier = sample.identifier
        self.measurement = sample.measurement
        self.date = sample.date
    }
    
    var body: some View {
        VStack {
            LabeledContent("Weight") {
                Text(measurement, format: .measurement(width: .abbreviated, usage: .asProvided, numberFormatStyle: .number.precision(.fractionLength(0...2))))
                    .font(.body)
            }
            .font(.headline)
            
            LabeledContent("Date") {
                Text(date, format: .dateTime
                    .day()
                    .month(.wide)
                    .year()
                )
                .font(.body)
            }
            .font(.headline)
            
            LabeledContent("Time") {
                Text(date, format: .dateTime
                    .hour(.defaultDigits(amPM: .abbreviated))
                    .minute(.twoDigits)
                    .timeZone()
                )
                .font(.body)
            }
            .font(.headline)
            
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    self.isShowingEditor.toggle()
                } label: {
                    Text("Edit")
                }
            }
        }
    }
}

struct MeasurementSampleView_Previews: PreviewProvider {
    private static let bodyWeightSample = BodyWeightSample(
        quantity: .init(
            identifier: .bodyMass,
            measurement: .init(value: 124.0123456789, unit: .kilograms),
            existingID: nil
        ),
        date: .now
    )
    
    static var previews: some View {
        MeasurementSampleView(sample: bodyWeightSample, editorToggle: .constant(false))
    }
}
