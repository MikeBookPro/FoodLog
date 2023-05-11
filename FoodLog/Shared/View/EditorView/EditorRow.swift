import SwiftUI

struct EditorRow<Value, Label: View, Content: View>: View {
    @Environment(\.editMode) private var editMode
    @Binding var value: Value
    let labelView: Label
    let viewBuilder: (Binding<Value>) -> Content
    
    init(_ textKey: SwiftUI.LocalizedStringKey, editing value: Binding<Value>, @ViewBuilder content viewBuilder: @escaping (Binding<Value>) -> Content) where Label == Text {
        self.init(label: Text(textKey), editing: value, content: viewBuilder)
    }
    
    init(_ text: some StringProtocol, editing value: Binding<Value>, @ViewBuilder content viewBuilder: @escaping (Binding<Value>) -> Content) where Label == Text {
        self.init(label: Text(text), editing: value, content: viewBuilder)
    }
    
    init(editing value: Binding<Value>, @ViewBuilder label buildLabel: () -> Label, @ViewBuilder content viewBuilder: @escaping (Binding<Value>) -> Content) {
        self.init(label: buildLabel(), editing: value, content: viewBuilder)
    }
    
    init(label: Label, editing value: Binding<Value>, @ViewBuilder content viewBuilder: @escaping (Binding<Value>) -> Content) {
        self._value = value
        self.labelView = label
        self.viewBuilder = viewBuilder
    }
    
    var body: some View {
        LabeledContent {
            if editMode?.wrappedValue == .active {
                viewBuilder($value)
                    .multilineTextAlignment(.trailing)
                    .font(.body)
                    .padding(.vertical, 8)
            } else {
                Text("VIEW-ONLY")
                    .multilineTextAlignment(.trailing)
                    .font(.body)
                    .padding(.vertical, 8)
            }
            
        } label: {
            labelView
                .font(.headline)
                .fixedSize()
        }
        
    }
}

#if DEBUG
struct EditorRow_Previews: PreviewProvider {
    
    private struct Shim: View {
        @Environment(\.editMode) private var editMode
        
        private struct ViewModel {
            enum Field: Hashable { case date, firstName, details, amount, measure }
            
            var date: Date = .now
            var givenName: String = ""
            var details: String = ""
            var amount: Double = 15.5
            var measure: Measurement<UnitMass> = .init(value: 16.5, unit: .grams)
        }
        @State private var vm = ViewModel()
        @FocusState private var activeField: ViewModel.Field?
        
        var body: some View {
            NavigationView {
                Form {
                    EditorRow("Date", editing: $vm.date) {
                        DatePicker("", selection: $0, in: (.distantPast)...(.now), displayedComponents: [.hourAndMinute, .date])
                            .focused($activeField, equals: .date)
                    }
                    
                    EditorRow("Details", editing: $vm.details) {
                        TextField(text: $0, prompt: Text("Enter your some info"), label: { EmptyView() })
                            .focused($activeField, equals: .details)
                            .autocorrectionDisabled(true)
                            .editorRow(textStyle: [.preferContinue])
                    }
                    
                    EditorRow("First name", editing: $vm.givenName) {
                        TextField(text: $0, prompt: Text("Enter your first name"), label: { EmptyView() })
                            .focused($activeField, equals: .firstName)
                            .textContentType(.givenName)
                            .editorRow(textStyle: [.standard])
                    }
                    
                    EditorRow("Amount", editing: $vm.amount) {
                        TextField("Enter value", value: $0, format: .number.precision(.fractionLength(0...2)))
                            .focused($activeField, equals: .amount)
                            .editorRow(decimalStyle: [.decimalInput])
                    }
                    
                    EditorRow("Measurement", editing: $vm.measure.value) {
                        TextField("Enter value", value: $0, format: .number.precision(.fractionLength(0...2)))
                            .focused($activeField, equals: .measure)
                            .editorRow(decimalStyle: [.decimalInput])
                        
                        Text(vm.measure.unit.symbol)
                    }
                    
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                }
            }
            
        }
    }
    
    static var previews: some View {
        Shim()
    }
}
#endif
