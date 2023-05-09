import SwiftUI

struct SampleQuantityForm: EditorViewRepresentable {
    @Environment(\.dismiss) private var dismiss
    
    private enum Field: Hashable { case date, value }
    @FocusState private var activeField: Field?
    
    @State private var value: Double
    @State private var date: Date
    private let identifier: QuantityIdentifier
    private let existingID: UUID?
    
    init(_ model: SampleQuantity) {
        self._value = .init(initialValue: model.measurement.value)
        self._date = .init(initialValue: model.date)
        self.identifier = model.identifier
        self.existingID = model.id
    }
        
    var body: some View {
        Form {
            EditorRow("Date") {
                DatePicker("", selection: $date, in: (.distantPast)...(.now), displayedComponents: [.hourAndMinute, .date])
                    .focused($activeField, equals: .date)
            }
            
            EditorRow("Value") {
                TextField("Enter value", value: $value, format: .number.precision(.fractionLength(0...2)))
                    .focused($activeField, equals: .value)
                    .editorRow(decimalStyle: [.decimalInput])
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem.cancel(id: "FoodItemForm.toolbar.cancel", action: didClickCancel)
            ToolbarItem.save(id: "FoodItemForm.toolbar.save", action: didClickSave)
        }
    }
    
    func didClickSave() {
        let measurement = Measurement(value: value, unit: IdentifierToDimensionAdapter.value(mappedTo: identifier))
        let model = SampleQuantity(quantity: .init(identifier: identifier, measurement: measurement, id: existingID), date: date)
        if existingID == nil {
            self.create(model)
        } else {
            self.update(model)
        }
        dismiss()
    }
    
    func didClickCancel() {
        dismiss()
    }
    
}

#if DEBUG
struct SampleQuantityForm_Previews: PreviewProvider {
    static let sample = PreviewData.quantitySamples(for: .bodyMass, count: 1, in: 117.0...125.0).first!
    
    static var previews: some View {
        NavigationView {
            SampleQuantityForm(sample)
        }
        
    }
}
#endif



