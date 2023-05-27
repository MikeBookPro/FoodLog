//

import SwiftUI

struct MeasurementForm: View {
  @Environment(\.editMode) private var editMode
  @FocusState private var activeField: Self.InputFocus?
  @Binding var measure: Measurement<Dimension>
  @State private var unit: Dimension

  init(measure: Binding<Measurement<Dimension>>) {
    _measure = measure
    _unit = .init(initialValue: measure.wrappedValue.unit)
  }

  var body: some View {
    EditorRow(editing: $measure) {
      Text(editMode?.wrappedValue == .inactive ? "Amount" : "")
    } readView: { measurement in
      Text(measurement, format: .measurementStyle)
    } editView: { boundMeasure in
      VStack {
        MeasurementPickerHost(selected: $unit, keyPaths: (\.rawValue, \.symbol)) {
          LabeledContent {
            TextField("Enter value", value: boundMeasure.value, format: .number.precision(.fractionLength(0...2)))
              .focused($activeField, equals: .textField)
              .editorRow(decimalStyle: [.decimalInput])
          } label: {
            Text("Amount")
              .font(.headline)
              .fixedSize()
          }
        }
      }
      .onChange(of: unit) {
        measure = .init(value: measure.value, unit: $0)
      }
    }
  }
}

extension MeasurementForm {
  enum InputFocus: String { case textField }
}

#if DEBUG
struct MeasurementForm_Previews: PreviewProvider {
  private struct ShimForm: View {
    @State private var value: Measurement<Dimension> = .init(value: 10.0, unit: UnitMass.kilograms)

    var body: some View {
      Form {
        Section("View Only") {
          Text(value, format: .measurementStyle)
        }

        Section("Editable") {
          Shim(boundValue: $value)
        }
      }
    }
  }

  private struct Shim: View {
    @Binding var boundValue: Measurement<Dimension>
    @State private var editingValue: Measurement<Dimension>

    init(boundValue: Binding<Measurement<Dimension>>) {
      _boundValue = boundValue
      _editingValue = .init(initialValue: boundValue.wrappedValue)
    }

    var body: some View {
      MeasurementForm(measure: $editingValue)
        .environment(\.editMode, .constant(.active))
        .toolbar {
          ToolbarItem.cancel(id: "\(String(describing: Self.self)).toolbar.cancel", action: didClickCancel)
          ToolbarItem.save(id: "\(String(describing: Self.self)).toolbar.save", action: didClickSave)
        }
    }

    private func didClickSave() {
      boundValue = editingValue
    }

    private func didClickCancel() {
      editingValue = boundValue
    }
  }

  static var previews: some View {
    NavigationView {
      ShimForm()
    }
  }
}
#endif
