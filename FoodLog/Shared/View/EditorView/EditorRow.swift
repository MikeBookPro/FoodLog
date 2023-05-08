import SwiftUI

struct EditorRow<Label: View, Content: View>: View {
    let labelView: Label
    let contentView: Content
    
    init(_ text: some StringProtocol, @ViewBuilder content viewBuilder: () -> Content) where Label == Text {
        self.init(label: Text(text), content: viewBuilder)
    }
    
    init(@ViewBuilder label buildLabel: () -> Label, @ViewBuilder content viewBuilder: () -> Content) {
        self.init(label: buildLabel(), content: viewBuilder)
    }
    
    init(label: Label, @ViewBuilder content viewBuilder: () -> Content) {
        self.labelView = label
        self.contentView = viewBuilder()
    }
    
    var body: some View {
        LabeledContent {
            contentView
                .multilineTextAlignment(.trailing)
                .font(.body)
                .padding(.vertical, 8)
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
                    EditorRow("Date") {
                        DatePicker("", selection: $vm.date, in: (.distantPast)...(.now), displayedComponents: [.hourAndMinute, .date])
                            .focused($activeField, equals: .date)
                    }
                    
                    EditorRow("Details") {
                        TextField(text: $vm.details, prompt: Text("Enter your some info"), label: { EmptyView() })
                            .focused($activeField, equals: .details)
                            .autocorrectionDisabled(true)
                            .editorRow(textStyle: [.preferContinue])
                    }
                    
                    EditorRow("First name") {
                        TextField(text: $vm.givenName, prompt: Text("Enter your first name"), label: { EmptyView() })
                            .focused($activeField, equals: .firstName)
                            .textContentType(.givenName)
                            .editorRow(textStyle: [.standard])
                    }
                    
                    EditorRow("Amount") {
                        TextField("Enter value", value: $vm.amount, format: .number.precision(.fractionLength(0...2)))
                            .focused($activeField, equals: .amount)
                            .editorRow(decimalStyle: [.decimalInput])
                    }
                    
                    EditorRow("Measurement") {
                        TextField("Enter value", value: $vm.measure.value, format: .number.precision(.fractionLength(0...2)))
                            .focused($activeField, equals: .measure)
                            .editorRow(decimalStyle: [.decimalInput])
                        
                        Text(vm.measure.unit.symbol)
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
