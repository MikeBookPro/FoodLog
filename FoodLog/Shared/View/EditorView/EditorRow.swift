import SwiftUI

struct EditorRow<Value: Equatable, Label: View, EditView: View, ReadView: View>: View {
    @Environment(\.editMode) private var editMode
    @Binding var value: Value
    let labelView: Label
    let editViewBuilder: (Binding<Value>) -> EditView
    let readViewBuilder: (Value) -> ReadView

    init(
        _ textKey: SwiftUI.LocalizedStringKey,
        editing value: Binding<Value>,
        @ViewBuilder readView buildReader: @escaping (Value) -> ReadView,
        @ViewBuilder editView buildEditor: @escaping (Binding<Value>) -> EditView
    ) where Label == Text {
        self.init(editing: value, label: Text(textKey), readView: buildReader, editView: buildEditor)
    }

    init(
        _ text: some StringProtocol = "",
        editing value: Binding<Value>,
        @ViewBuilder readView buildReader: @escaping (Value) -> ReadView,
        @ViewBuilder editView buildEditor: @escaping (Binding<Value>) -> EditView
    ) where Label == Text {
        self.init(editing: value, label: Text(text), readView: buildReader, editView: buildEditor)
    }

    init<ValueStyle: FormatStyle>(
        _ textKey: SwiftUI.LocalizedStringKey,
        editing value: Binding<Value>,
        readFormat style: ValueStyle,
        @ViewBuilder editView buildEditor: @escaping (Binding<Value>) -> EditView
    ) where Label == Text, ReadView == Text, ValueStyle.FormatOutput == String, ValueStyle.FormatInput == Value {
        self.init(editing: value, label: Text(textKey), readView: { value in
            Text(value, format: style)
        }, editView: buildEditor)
    }

    init(
        _ text: some StringProtocol,
        editing value: Binding<Value>,
        @ViewBuilder editView buildEditor: @escaping (Binding<Value>) -> EditView
    ) where Label == Text, ReadView == Text, Value == String {
        self.init(editing: value, label: Text(text), readView: { Text($0) }, editView: buildEditor)
    }

    init(
        editing value: Binding<Value>,
        @ViewBuilder label buildLabel: () -> Label,
        @ViewBuilder readView buildReader: @escaping (Value) -> ReadView,
        @ViewBuilder editView buildEditor: @escaping (Binding<Value>) -> EditView
    ) {
        self.init(editing: value, label: buildLabel(), readView: buildReader, editView: buildEditor)
    }

    init(
        editing value: Binding<Value>,
        label: Label,
        @ViewBuilder readView buildReader: @escaping (Value) -> ReadView,
        @ViewBuilder editView buildEditor: @escaping (Binding<Value>) -> EditView
    ) {
        _value = value
        labelView = label
        readViewBuilder = buildReader
        editViewBuilder = buildEditor

    }

    var body: some View {
        LabeledContent {
            Group {
                if editMode?.wrappedValue == .active {
                    editViewBuilder($value)
                } else {
                    readViewBuilder(value)
                }
            }
            .multilineTextAlignment(.trailing)
            .font(.body)
            .padding(.vertical, 8)

        } label: {
            labelView
                .font(.headline)
                .fixedSize()
        }

    }

    // TODO: Move these to be shared, probably replace with FormatStyle
    static func displayText(forDate value: Date) -> String {
        value.formatted(.dateTime
            .day()
            .month(.wide)
            .year()
            .hour(.defaultDigits(amPM: .abbreviated))
            .minute(.twoDigits)
            .timeZone()
        )
    }

    static func displayText(forDouble value: Double) -> String {
        value.formatted(.number.precision(.fractionLength(0...2)))
    }

    static func displayText<UnitType: Dimension>(forMeasurement value: Measurement<UnitType>) -> String {
        value.formatted(.measurement(width: .abbreviated, numberFormatStyle: .number.precision(.fractionLength(0...2))))
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

            func displayText(forDate value: Date) -> String {
                value.formatted(.dateTime
                    .day()
                    .month(.wide)
                    .year()
                    .hour(.defaultDigits(amPM: .abbreviated))
                    .minute(.twoDigits)
                    .timeZone()
                )
            }

            func displayText(forDouble value: Double) -> String {
                value.formatted(.number.precision(.fractionLength(0...2)))
            }

            func displayText<UnitType: Dimension>(forMeasurement value: Measurement<UnitType>) -> String {
                value.formatted(.measurement(width: .abbreviated, numberFormatStyle: .number.precision(.fractionLength(0...2))))
            }
        }
        @State private var vm = ViewModel()
        @FocusState private var activeField: ViewModel.Field?

        let dateFormat: any FormatStyle = .dateTime.day().month(.wide).year().hour(.defaultDigits(amPM: .abbreviated)).minute(.twoDigits).timeZone()

        var body: some View {
            NavigationView {
                EditorRow("Date", editing: $vm.date, readFormat: .dateTime.day().month(.wide).year().hour(.defaultDigits(amPM: .abbreviated)).minute(.twoDigits).timeZone()) { boundValue in
                    DatePicker("", selection: boundValue, in: (.distantPast)...(.now), displayedComponents: [.hourAndMinute, .date])
                }

                EditorRow("Details", editing: $vm.details) { boundValue in
                    TextField(text: boundValue, prompt: Text("Enter some info"), label: { EmptyView() })
                        .focused($activeField, equals: .details)
                        .editorRow(textStyle: [.standard])
                }

                EditorRow("First name", editing: $vm.givenName) { boundValue in
                    TextField(text: boundValue, prompt: Text("Enter your first name"), label: { EmptyView() })
                        .focused($activeField, equals: .firstName)
                        .textContentType(.givenName)
                        .editorRow(textStyle: [.standard])
                }

                EditorRow("First name", editing: $vm.givenName) { boundValue in
                    TextField(text: boundValue, prompt: Text("Enter your first name"), label: { EmptyView() })
                        .focused($activeField, equals: .firstName)
                        .textContentType(.givenName)
                        .editorRow(textStyle: [.standard])
                }

                EditorRow("Amount", editing: $vm.amount, readFormat: .number.precision(.fractionLength(0...2))) { boundValue in
                    TextField("Enter value", value: boundValue, format: .number.precision(.fractionLength(0...2)))
                        .focused($activeField, equals: .amount)
                        .editorRow(decimalStyle: [.decimalInput])
                }

                EditorRow("Measurement", editing: $vm.measure, readFormat: .measurement(width: .abbreviated, numberFormatStyle: .number.precision(.fractionLength(0...2)))) { boundValue in
                    TextField("Enter value", value: boundValue.value, format: .number.precision(.fractionLength(0...2)))
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

    static var previews: some View {
        Shim()
    }
}
#endif
