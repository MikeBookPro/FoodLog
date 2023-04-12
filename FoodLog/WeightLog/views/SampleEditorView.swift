import SwiftUI

struct SampleEditorView<Sample: SampledMeasurementInititializable>: View {
    
    private let sample: Sample

    @State private var date: Date
    @State private var value: Double?
    @FocusState private var valueFieldHasFocus: Bool
    
    private let onSave: ((Sample) -> Void)?
    private let onCancel: (() -> Void)?
    private let title: String
    
    private static var emptySample: Sample {
        Sample(
            quantity: Sample.IdentifiedMeasure(
                identifier: Sample.Identifier.baseIdentifier(),
                measurement: .init(value: .zero, unit: Sample.UnitType.baseUnit())
            ),
            dateRange: (nil, nil)
        )
    }
    
    private var newSample: Sample {
        Sample(
            quantity: .init(
                identifier: sample.identifier,
                measurement: .init(value: value ?? .zero, unit: sample.measurement.unit)
            ),
            dateRange: (date, date)
        )
        
//        MeasurementSample<IdentifiedMeasurement<BodyMeasurementQuantityType, UnitMass>>(
//            quantity: IdentifiedMeasurement<BodyMeasurementQuantityType, UnitMass>(
//                identifier: .bodyMass,
//                measurement: .init(value: .zero, unit: .kilograms)
//            ),
//            dateRange: (nil, nil)
//        )
    }
    
    init(sample: Sample? = nil, onSave: ((Sample) -> Void)? = nil, onCancel: (() -> Void)? = nil) {
        self.sample = sample ?? Self.emptySample
        self.onSave = onSave
        self.onCancel = onCancel
        self._date = .init(initialValue: sample?.dateRange.start ?? .now)
        self._value = .init(initialValue: sample?.measurement.value)
        self.title = sample == nil ? "Add Sample" : "Edit Sample"
    }
    
    var body: some View {
        NavigationView {
            Form {
                DatePicker(
                    "Date",
                    selection: $date,
                    in: (.distantPast)...(.now),
                    displayedComponents: [.hourAndMinute, .date]
                )
                .padding(.vertical)
                
                LabeledContent("Weight") {
                    TextField("Enter value", value: $value, format: .number.precision(.fractionLength(0...2)))
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.decimalPad)
                        .submitLabel(.done)
                        .focused($valueFieldHasFocus)
                        .toolbar {
                            ToolbarItemGroup(placement: .keyboard) {
                                Spacer()
                                Button("Done") {
                                    valueFieldHasFocus.toggle()
                                }
                                
                            }
                        }
                }
                .padding(.vertical)
            }
            .navigationTitle(self.title)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(role: .cancel) {
                        self.onCancel?()
                    } label: {
                        Text("Cancel")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        self.onSave?(newSample)
                    } label: {
                        Text("Save")
                    }
                }
            }
        }
        
    }
}

struct SampleEditorView_Previews: PreviewProvider {
    static var previews: some View {
        SampleEditorView<MeasurementSample<IdentifiedMeasurement<BodyMeasurementQuantityType, UnitMass>>>()
    }
}



