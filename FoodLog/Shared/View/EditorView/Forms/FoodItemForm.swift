//import SwiftUI
//
//struct FoodItemForm: EditorViewRepresentable {
//  typealias Model = FoodItem
//  @Environment(\.dismiss) private var dismiss
//  @Environment(\.editMode) private var editMode
//  @FocusState private var activeField: Self.InputFocus?
//  @State private var viewModel: Self.ViewModel
//
//  init(_ model: FoodItem) {
//    _viewModel = .init(initialValue: ViewModel(foodItem: model))
//  }
//
//  var body: some View {
//    Form {
//      NutritionInfoForm(
//        servingSize: $viewModel.nutritionInfo.servingSize.measurement,
//        nutrientRows: $viewModel.nutrientRows
//      )
//    }
//    .navigationBarBackButtonHidden(editMode?.wrappedValue == .active)
//    .toolbar {
//      if editMode?.wrappedValue == .active {
//        ToolbarItem.cancel(id: "\(viewName).toolbar.cancel", action: didClickCancel)
//        ToolbarItem.save(id: "\(viewName).toolbar.save", action: didClickSave)
//      } else {
//        ToolbarItem.edit(id: "\(viewName).toolbar.edit", action: didClickEdit)
//      }
//    }
//  }
//
//  func didClickSave() {
//    let isEditing = editMode?.wrappedValue != .inactive
//    let shouldDismiss = editMode?.wrappedValue == .transient
//    guard isEditing else { return }
//
//    viewModel.user(didTap: .save)
//    if shouldDismiss {
//      dismiss()
//    } else {
//      editMode?.wrappedValue = .inactive
//    }
//  }
//
//  func didClickCancel() {
//    let isEditing = editMode?.wrappedValue != .inactive
//    let shouldDismiss = editMode?.wrappedValue == .transient
//    guard isEditing else { return }
//
//    viewModel.user(didTap: .cancel)
//    if shouldDismiss {
//      dismiss()
//    } else {
//      editMode?.wrappedValue = .inactive
//    }
//  }
//
//  func didClickEdit() {
//    let isViewing = editMode?.wrappedValue == .inactive
//    guard isViewing else { return }
//
//    editMode?.wrappedValue = .active
//  }
//}
//
//// MARK: - View Model
//extension FoodItemForm {
//  enum InputFocus: Hashable {
//    case basicInfo
//
//    private var sectionKey: String {
//      switch self {
//        case .basicInfo: return "basicInfo"
//      }
//    }
//
//    func hash(into hasher: inout Hasher) {
//      hasher.combine(self.sectionKey)
//    }
//  }
//
//  enum TapTarget { case cancel, save }
//
//  struct ActionOption: OptionSet {
//    let rawValue: UInt16
//
//    static let toggleEditMode = Self(rawValue: 1 << 0)
//    static let dismissView = Self(rawValue: 1 << 1)
//  }
//
//  private struct ViewModel {
//    let foodItem: FoodItem
////    var nutritionInfo: NutritionInfo
//    var isShowingUnitRow = false
////    var servingSize: QuantityRowViewModel
////    var nutrientRows: [QuantityRowViewModel]
//
//    init(foodItem model: FoodItem) {
//      self.foodItem = model
////      self.nutritionInfo = model.nutritionInfo
////      self.servingSize = QuantityRowViewModel(qty: model.nutritionInfo.servingSize)
////      self.nutrientRows = QuantityRowViewModel.rows(for: model.nutritionInfo.nutrientQuantities)
//    }
//
//
//    func user(didTap target: FoodItemForm.TapTarget) {
//      switch target {
//        case .cancel:
//          print("TODO: Cancel")
//        case .save:
//          print("TODO: Save")
//      }
//    }
//  }
//}
//
//#if DEBUG
////struct FoodItemForm_Previews: PreviewProvider {
////  private struct Shim: View {
////    @State private var editMode: EditMode = .inactive
////    let foodItem: FoodItem
////
////    var body: some View {
////      FoodItemForm(foodItem)
////        .environment(\.editMode, $editMode)
////    }
////  }
////
////  static var previews: some View {
////    ForEach(["en", "es"], id: \.self) { localeIdentifier in
////      NavigationView {
////        Shim(foodItem: PreviewData.Food.mayonnaise)
////          .environment(\.locale, .init(identifier: localeIdentifier))
////      }
////
////      .previewDisplayName("Locale: \(localeIdentifier)")
////    }
////  }
////}
//#endif
