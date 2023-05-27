//

import SwiftUI

struct NutritionInfoForm: View {
  @FocusState private var activeField: Self.InputFocus?
  @Binding var servingSize: Measurement<Dimension>
  @Binding var nutrientRows: [QuantityRowViewModel]

  var body: some View {
    Section(IdentifierToLocalizedString.value(mappedTo: .servingSize)) {
      MeasurementForm(measure: $servingSize)
    }

    Section("Nutrition info") {
      ForEach(Array(zip(nutrientRows.indices, nutrientRows)), id: \.0) { i, row in
        EditorRow(
          row.title,
          editing: $nutrientRows[i].measurement,
          readFormat: .measurementStyle
        ) { boundValue in
          TextField("Enter value", value: boundValue.value, format: .twoDecimalMaxStyle)
            .focused($activeField, equals: .quantity(row.identifier))
            .editorRow(decimalStyle: [.decimalInput])

          Text(row.measurement.unit.symbol)
        }
      }
    }
  }
}

// MARK: - View Model
extension NutritionInfoForm {
  enum InputFocus: Hashable {
    case quantity(_ identifier: QuantityIdentifier)

    func hash(into hasher: inout Hasher) {
      guard case let .quantity(identifier) = self else { return }

      hasher.combine(identifier)
    }
  }
}

#if DEBUG
struct NutritionInfoForm_Previews: PreviewProvider {
  private struct ShimForm: View {
    @State private var egg = PreviewData.Food.egg.nutritionInfo

    var body: some View {
      NavigationView {
        Shim(boundValue: $egg)
      }
    }
  }

  private struct Shim: View {
    @Binding var boundValue: NutritionInfo
    @State var servingSize: Measurement<Dimension>
    @State var nutrientRows: [QuantityRowViewModel]

    init(boundValue: Binding<NutritionInfo>) {
      _boundValue = boundValue
      _servingSize = .init(initialValue: boundValue.wrappedValue.servingSize.measurement)
      _nutrientRows = .init(initialValue: boundValue.wrappedValue.nutrientQuantities.map(QuantityRowViewModel.init(qty:))) // swiftlint:disable:this line_length
    }

    var body: some View {
      Form {
        Section("View Only") {
          LabeledContent("Serving size") {
            Text(boundValue.servingSize.measurement, format: .measurementStyle)
              .foregroundColor(.red)
          }
        }

        NutritionInfoForm(servingSize: $servingSize, nutrientRows: $nutrientRows)
      }
      .environment(\.editMode, .constant(.active))
      .toolbar {
        ToolbarItem.cancel(id: "\(String(describing: Self.self)).toolbar.cancel", action: didClickCancel)
        ToolbarItem.save(id: "\(String(describing: Self.self)).toolbar.save", action: didClickSave)
      }
    }

    private func didClickSave() {
      boundValue = .init(
        servingSize: .init(identifier: .servingSize, measurement: servingSize, id: boundValue.servingSize.id),
        nutrientQuantities: nutrientRows.map {
          Quantity(identifier: $0.identifier, measurement: $0.measurement, id: $0.id)
        }
      )
    }

    private func didClickCancel() {
      servingSize = boundValue.servingSize.measurement
      nutrientRows = boundValue.nutrientQuantities.map(QuantityRowViewModel.init(qty:))
    }
  }

  static var previews: some View {
    ShimForm()
  }
}
#endif
