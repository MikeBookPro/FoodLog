import SwiftUI

struct SampleEditorView<Sample: SampledMeasurement>: View {
    @State private var date: Date
    @State private var value: Double?
    @FocusState private var valueFieldHasFocus: Bool
    
    @DimensionPreference<Sample.UnitType>
    private var quantityIdentifier: QuantityIdentifier
    private let sampleID: UUID?
    private let onSave: ((Sample) -> Void)?
    private let onCancel: (() -> Void)?
    
    
    private var sample: Sample {
        let s = Sample(
            quantity: .init(
                identifier: quantityIdentifier,
                measurement: .init(value: value ?? .zero, unit: $quantityIdentifier),
                existingID: sampleID
            ),
            date: date
        )
        
        return s
    }
    
    init(update sample: Sample, onSave save: ((Sample) -> Void)? = nil, onCancel cancel: (() -> Void)? = nil) {
        self._value = .init(initialValue: sample.measurement.value.isZero ? nil : sample.measurement.value)
        self._date = .init(initialValue: sample.date)
        self.sampleID = sample.id
        self.quantityIdentifier = sample.identifier
        self.onSave = save
        self.onCancel = cancel
    }
    
    init(_ quantityIdentifier: QuantityIdentifier, onSave save: ((Sample) -> Void)? = nil, onCancel cancel: (() -> Void)? = nil) {
        self.init(
            update: Sample(
                identifier: quantityIdentifier,
                measurement: .init(
                    value: .zero,
                    unit: DimensionPreference(wrappedValue: quantityIdentifier).projectedValue
                )
            ),
            onSave: save,
            onCancel: cancel
        )
    }
    
    var body: some View {
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
        .navigationBarTitleDisplayMode(.inline)
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
                    self.onSave?(sample)
                } label: {
                    Text("Save")
                }
            }
        }
    }
}

struct SampleEditorView_Previews: PreviewProvider {
    
    static var previews: some View {
        SampleEditorView<BodyWeightSample>(.bodyMass)
    }
}



