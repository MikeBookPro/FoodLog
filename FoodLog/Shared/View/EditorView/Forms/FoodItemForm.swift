import SwiftUI

struct DimensionPicker: View {
  @Binding var selected: Dimension
  let options: [Dimension]

  var body: some View {
    Picker("", selection: $selected) {
      ForEach(options, id: \.self) {
        Text($0.symbol)
          .tag($0)
      }
    }
  }
}

struct FoodItemForm: EditorViewRepresentable {
  typealias Model = FoodItem
  @Environment(\.dismiss) private var dismiss
  @Environment(\.editMode) private var editMode
  @FocusState private var activeField: ViewModel.InputFocus?
  @State private var viewModel: Self.ViewModel

  init(_ model: FoodItem) {
    _viewModel = .init(initialValue: ViewModel(foodItem: model))
  }

  var body: some View {
    Form {
      Section(IdentifierToLocalizedString.value(mappedTo: .servingSize)) {
        EditorRow(
          "Amount",
          editing: $viewModel.servingSize.measurement,
          readFormat: .measurement(width: .abbreviated, numberFormatStyle: .number.precision(.fractionLength(0...2)))
        ) { boundValue in
          TextField("Enter value", value: boundValue.value, format: .number.precision(.fractionLength(0...2)))
            .focused($activeField, equals: .servingSize)
            .editorRow(decimalStyle: [.decimalInput])

          //                    MeasurementPickerHost(selected: boundValue., keyPaths: (unitType: \.rawValue, dimension: \.symbol))

          //                    MeasurementPickerHost("Select a unit of measure", selected: Dimension(symbol: "g")) { unitType in
          //                        Text(unitType.rawValue)
          //                    } dimensionView: { dimension in
          //                        Text(dimension.symbol)
          //                            .tag()
          //                    }

          //                    DimensionPicker(selected: $viewModel.servingSize.unit, options: UnitType(unit: viewModel.servingSize.unit).dimensions )
          //                        .scaledToFit()
        }
      }

      Section("Nutrition info") {
        NutritionInfoForm(nutritionInfo: viewModel.foodItem.nutritionInfo)
      }
    }
    .navigationBarBackButtonHidden(editMode?.wrappedValue == .active)
    .toolbar {
      if editMode?.wrappedValue == .active {
        ToolbarItem.cancel(id: "\(viewName).toolbar.cancel", action: didClickCancel)
        ToolbarItem.save(id: "\(viewName).toolbar.save", action: didClickSave)
      } else {
        ToolbarItem.edit(id: "\(viewName).toolbar.edit", action: didClickEdit)
      }
    }
  }

  func didClickSave() {
    let isEditing = editMode?.wrappedValue != .inactive
    let shouldDismiss = editMode?.wrappedValue == .transient
    guard isEditing else { return }

    viewModel.user(didTap: .save)
    if shouldDismiss {
      dismiss()
    } else {
      editMode?.wrappedValue = .inactive
    }
  }

  func didClickCancel() {
    let isEditing = editMode?.wrappedValue != .inactive
    let shouldDismiss = editMode?.wrappedValue == .transient
    guard isEditing else { return }

    viewModel.user(didTap: .cancel)
    if shouldDismiss {
      dismiss()
    } else {
      editMode?.wrappedValue = .inactive
    }
  }

  func didClickEdit() {
    let isViewing = editMode?.wrappedValue == .inactive
    guard isViewing else { return }

    editMode?.wrappedValue = .active
  }
}

// MARK: - View Model
extension FoodItemForm {
  private struct ViewModel {
    enum TapTarget { case cancel, save }
    enum InputFocus: Hashable {
      case basicInfo
      case servingSize
      case quantity(_ identifier: QuantityIdentifier)

      private var sectionKey: String {
        switch self {
          case .basicInfo: return "basicInfo"
          case .servingSize: return "servingSize"
          case .quantity: return "quantity"
        }
      }

      func hash(into hasher: inout Hasher) {
        hasher.combine(self.sectionKey)
        switch self {
          case .quantity(identifier: let identifier): hasher.combine(identifier)
          default: return
        }
      }
    }

    let foodItem: FoodItem

    var isShowingUnitRow = false

    var servingSize: RowViewModel

    init(foodItem model: FoodItem) {
      self.foodItem = model
      self.servingSize = RowViewModel(forNutrient: model.nutritionInfo.servingSize)
    }

    func user(didTap target: TapTarget) {
      switch target {
        case .cancel:
          print("TODO: Cancel")
        case .save:
          print("TODO: Save")
      }
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
struct FoodItemForm_Previews: PreviewProvider {
  private struct Shim: View {
    @State private var editMode: EditMode = .inactive
    let foodItem: FoodItem

    var body: some View {
      FoodItemForm(foodItem)
        .environment(\.editMode, $editMode)
    }
  }

  static var previews: some View {
    ForEach(["en", "es"], id: \.self) { localeIdentifier in
      NavigationView {
        Shim(foodItem: PreviewData.Food.mayonnaise)
          .environment(\.locale, .init(identifier: localeIdentifier))
      }

      .previewDisplayName("Locale: \(localeIdentifier)")
    }
  }
}
#endif
