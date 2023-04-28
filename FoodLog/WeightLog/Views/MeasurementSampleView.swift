//

import SwiftUI

struct MeasurementSampleView<Sample: SampledMeasurement>: View {
    @State private var editMode: EditMode = .inactive
    private let id: UUID?
    private let identifier: QuantityIdentifier
    private let measurement: Measurement<Sample.UnitType>
    private let date: Date
    
    init(sample: Sample) {
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
            if editMode == .active {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(role: .cancel) {
                        editMode = .inactive
                    } label: {
                        Text("Cancel")
                    }
                }
            }
            

            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    self.editMode = editMode.isEditing ? .inactive : .active
                } label: {
                    Text(editMode.isEditing ?  "Save" : "Edit")
                }
            }
        }
        .navigationBarBackButtonHidden(editMode.isEditing)
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
        MeasurementSampleView(sample: bodyWeightSample)
    }
}
