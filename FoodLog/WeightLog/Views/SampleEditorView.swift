import SwiftUI

struct SampleEditorView: View {
    @State private var date: Date
    @State private var value: Double?
    @FocusState private var valueFieldHasFocus: Bool
    
    @Dimensioned
    private var quantityIdentifier: QuantityIdentifier
    private let sampleID: UUID?
    private let onSave: ((SampleQuantity) -> Void)?
    private let onCancel: (() -> Void)?
    
    
    private var sample: SampleQuantity {
        let s = SampleQuantity(
            quantity: .init(
                identifier: quantityIdentifier,
                measurement: .init(value: value ?? .zero, unit: $quantityIdentifier),
                id: sampleID
            ),
            date: date
        )
        
        return s
    }
    
    init(update sample: some SampleQuantityRepresentable, onSave save: ((SampleQuantity) -> Void)? = nil, onCancel cancel: (() -> Void)? = nil) {
        self._value = .init(initialValue: sample.measurement.value.isZero ? nil : sample.measurement.value)
        self._date = .init(initialValue: sample.date)
        self.sampleID = sample.id
        self.quantityIdentifier = sample.identifier
        self.onSave = save
        self.onCancel = cancel
    }
    
    init(_ quantityIdentifier: QuantityIdentifier, onSave save: ((SampleQuantity) -> Void)? = nil, onCancel cancel: (() -> Void)? = nil) {
        self.init(
            update: SampleQuantity(
                quantity: .init(
                    identifier: quantityIdentifier,
                    measurement: .init(value: .zero, unit: IdentifierToDimensionAdapter.value(mappedTo: quantityIdentifier))
                ),
                date: .now
            ),
            onSave: save,
            onCancel: cancel
        )
    }
    
    var body: some View {
        Form {
            Text(sampleID?.uuidString ?? "No sampleID, is creating new")
            
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

#if DEBUG
struct SampleEditorView_Previews: PreviewProvider {
    static var previews: some View {
        SampleEditorView(.bodyMass)
    }
}
#endif



