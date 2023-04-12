import SwiftUI

struct SampleEditorView<Sample: SampledMeasurement>: View {
    @State private var date: Date
    @State private var value: Double?
    @FocusState private var valueFieldHasFocus: Bool
    
    @DimensionPreference<Sample.UnitType>
    private var quantityIdentifier: QuantityIdentifier
    
    private let title: String
    private let onSave: ((Sample) -> Void)?
    private let onCancel: (() -> Void)?
    
    private var newSample: Sample {
        let s = Sample(
            quantity: .init(
                identifier: quantityIdentifier,
                measurement: .init(value: value ?? .zero, unit: $quantityIdentifier)
            ),
            dateRange: (date, date)
        )
        
        return s
    }
    
    init(_ quantityIdentifier: QuantityIdentifier, onSave save: ((Sample) -> Void)? = nil, onCancel cancel: (() -> Void)? = nil) {
        self.init(quantityIdentifier, date: .now, onSave: save, onCancel: cancel)
    }
    
    init(sample: Sample, onSave save: ((Sample) -> Void)? = nil, onCancel cancel: (() -> Void)? = nil) {
        self.init(sample.identifier, value: sample.measurement.value, date: sample.dateRange.start ?? .now, onSave: save, onCancel: cancel)
    }
    
    private init(_ quantityIdentifier: QuantityIdentifier, value: Double? = nil, date: Date, onSave save: ((Sample) -> Void)? = nil, onCancel cancel: (() -> Void)? = nil) {
        self._date = .init(initialValue: date)
        self._value = .init(initialValue: value)
        self.quantityIdentifier = quantityIdentifier
        self.onSave = save
        self.onCancel = cancel
        self.title = value == nil ? "Add Sample" : "Edit Sample"
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
        SampleEditorView<BodyWeightSample>(.bodyMass)
    }
}



