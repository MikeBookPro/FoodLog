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
        enum Field { case date, details, amount }
        
        @FocusState private var activeField: Field?
        @State private var date: Date = .now
        @State private var details: String = ""
        @State private var amount: Double = 15.5
        
        var body: some View {
            Form {
                EditorRow("Date") {
                    DatePicker("", selection: $date, in: (.distantPast)...(.now), displayedComponents: [.hourAndMinute, .date])
                        .focused($activeField, equals: .date)
                }
                
                EditorRow("Details") {
                    TextField(text: $details, prompt: Text("Enter your some info"), label: { EmptyView() })
                        .focused($activeField, equals: .details)
                        .editorRow(textStyle: [.preferContinue], onSubmit: {
                            activeField = .amount
                        })
                }
                
                EditorRow("Amount") {
                    TextField("Enter value", value: $amount, format: .number.precision(.fractionLength(0...2)))
                        .focused($activeField, equals: .date)
                        .editorRow(textStyle: .standard, onSubmit: {
                            activeField = nil
                        })
                }
                
            }
        }
    }
    
    static var previews: some View {
        Shim()
    }
}
#endif
