//

import SwiftUI

struct NutritionInfoForm: View {
  @FocusState private var activeField: Self.InputFocus?
  @State private var viewModel: Self.ViewModel

  init(nutritionInfo: NutritionInfo) {
    _viewModel = .init(initialValue: .init(model: nutritionInfo))
  }

  var body: some View {
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
    let nutritionInfo: NutritionInfo
    var rows: [RowViewModel]

    init(model: NutritionInfo) {
      self.nutritionInfo = model
      self.rows = RowViewModel.rows(for: model)
    }
  }

  struct RowViewModel: Identifiable {
    let title: LocalizedStringKey
    let id: UUID
    let identifier: QuantityIdentifier
    var measurement: Measurement<Dimension>

    init(forNutrient qty: Quantity) {
      self.id = qty.id
      self.identifier = qty.identifier
      self.measurement = qty.measurement
      self.title = IdentifierToLocalizedString.value(mappedTo: qty.identifier)
    }

    static func rows(for nutritionInfo: NutritionInfo) -> [Self] {
      nutritionInfo.nutrientQuantities.compactMap(Self.init(forNutrient:))
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
      .toolbar {
        EditButton()
      }
    }
  }

  static var previews: some View {
    NavigationView {
      Shim()
    }
  }
}
#endif
