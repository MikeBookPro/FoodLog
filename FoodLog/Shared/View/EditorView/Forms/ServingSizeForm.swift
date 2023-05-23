//

import SwiftUI

struct ServingSizeForm: View {
  @Environment(\.editMode) private var editMode
  @FocusState private var activeField: Self.InputFocus?
  @Binding var quantity: Quantity

  var body: some View {
    EditorRow(editing: $quantity.measurement) {
      Text(editMode?.wrappedValue == .inactive ? "Amount" : "")
    } readView: { measurement in
      Text(measurement, format: .measurementStyle)
    } editView: { boundMeasure in
      VStack {
        MeasurementPickerHost(selected: boundMeasure, keyPaths: (\.rawValue, \.symbol)) {
          LabeledContent {
            TextField("Enter value", value: boundMeasure.value, format: .number.precision(.fractionLength(0...2)))
              .focused($activeField, equals: .servingSize)
              .editorRow(decimalStyle: [.decimalInput])
          } label: {
            Text("Amount")
              .font(.headline)
              .fixedSize()
          }
        }
      }
    }
  }
}

extension ServingSizeForm {
  enum InputFocus: Hashable {
    case servingSize

    private var sectionKey: String {
      switch self {
        case .servingSize: return "servingSize"
      }
    }

    func hash(into hasher: inout Hasher) {
      hasher.combine(self.sectionKey)
    }
  }

  private struct ViewModel {
    var servingSize: Binding<Quantity>
  }
}

#if DEBUG
struct ServingSizeForm_Previews: PreviewProvider {
  private struct Shim: View {
    @State private var value = Quantity.template(for: .servingSize)

    var body: some View {
      ServingSizeForm(quantity: $value)
    }
  }

  static var previews: some View {
    NavigationView {
      Form {
        Shim()
          .toolbar { EditButton() }
      }
    }
  }
}
#endif
