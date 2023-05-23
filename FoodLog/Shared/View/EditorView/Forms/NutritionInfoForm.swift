//

import SwiftUI

struct NutritionInfoForm: View {
  @FocusState private var activeField: Self.InputFocus?
  @State private var viewModel: Self.ViewModel

  init(nutritionInfo: NutritionInfo) {
    _viewModel = .init(initialValue: .init(model: nutritionInfo))
  }

  var body: some View {
    Section(IdentifierToLocalizedString.value(mappedTo: .servingSize)) {
      ServingSizeForm(quantity: $viewModel.nutritionInfo.servingSize)
    }

    Section("Nutrition info") {
      ForEach(Array(zip(viewModel.rows.indices, viewModel.rows)), id: \.0) { i, row in
        EditorRow(
          row.title,
          editing: $viewModel.rows[i].measurement,
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

  private struct ViewModel {
    var nutritionInfo: NutritionInfo
    var rows: [QuantityRowViewModel]

    init(model: NutritionInfo) {
      self.nutritionInfo = model
      self.rows = QuantityRowViewModel.rows(for: model.nutrientQuantities)
    }
  }
}

#if DEBUG
struct NutritionInfoForm_Previews: PreviewProvider {
  private struct Shim: View {
    @State private var value = PreviewData.Food.egg.nutritionInfo

    var body: some View {
      Form {
        NutritionInfoForm(nutritionInfo: value)
      }
      .toolbar { EditButton() }
    }
  }

  static var previews: some View {
    NavigationView {
      Shim()
    }
  }
}
#endif
