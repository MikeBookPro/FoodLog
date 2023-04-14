import SwiftUI

struct SampleEditorView<Sample: SampledMeasurement>: View {
    @State private var date: Date = .now
    @State private var value: Double?
    @FocusState private var valueFieldHasFocus: Bool
    
    @DimensionPreference<Sample.UnitType>
    private var quantityIdentifier: QuantityIdentifier
    private let onSave: ((Sample) -> Void)?
    private let onCancel: (() -> Void)?
    
    
    private var newSample: Sample {
        let s = Sample(
            quantity: .init(
                identifier: quantityIdentifier,
                measurement: .init(value: value ?? .zero, unit: $quantityIdentifier),
                existingID: nil
            ),
            date: date
        )
        
        return s
    }
    
    
    
    init(_ quantityIdentifier: QuantityIdentifier, onSave save: ((Sample) -> Void)? = nil, onCancel cancel: (() -> Void)? = nil) {
        self._value = .init(initialValue: nil)
        self.quantityIdentifier = quantityIdentifier
        self.onSave = save
        self.onCancel = cancel
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
            .navigationTitle("Add Sample")
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



