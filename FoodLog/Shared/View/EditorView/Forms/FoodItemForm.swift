import SwiftUI

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
            Section("Nutrition Info") {
                ForEach(Array(zip(viewModel.nutrientRows.indices, viewModel.nutrientRows)), id: \.0) { (i, row) in
                    EditorRow(row.title, editing: $viewModel.nutrientRows[i].measurement.value) {
                        TextField(
                            "Enter value",
                            value: $0,
                            format: .number.precision(.fractionLength(0...2))
                        )
                        .focused($activeField, equals: .quantity(row.identifier))
                        .editorRow(decimalStyle: [.decimalInput])
                        
                        Text(row.measurement.unit.symbol)
                    }
                }
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
            case quantity(_ identifier: QuantityIdentifier)
            
            private var sectionKey: String {
                switch self {
                    case .quantity(identifier: _): return "quantity"
                }
            }
            
            func hash(into hasher: inout Hasher) {
                hasher.combine(self.sectionKey)
                switch self {
                    case .quantity(identifier: let identifier): hasher.combine(identifier)
                }
            }
        }
        
        let foodItem: FoodItem
        
        var nutrientRows: [NutrientRowViewModel]
        
        init(foodItem model: FoodItem) {
            self.foodItem = model
            self.nutrientRows = NutrientRowViewModel.rows(forFood: model)
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
    
    
    private struct NutrientRowViewModel: Identifiable {
        let id: UUID
        let identifier: QuantityIdentifier
        var measurement: Measurement<Dimension>
        let title: LocalizedStringKey
        
        private init(forNutrient qty: Quantity) {
            self.id = qty.id
            self.identifier = qty.identifier
            self.measurement = qty.measurement
            self.title = IdentifierToLocalizedString.value(mappedTo: qty.identifier)
        }
        
        static func rows(forFood item: FoodItem) -> [NutrientRowViewModel] {
            item.nutritionInfo.nutrientQuantities.compactMap(Self.init(forNutrient:))
        }
    }
}

#if DEBUG
struct FoodItemForm_Previews: PreviewProvider {
    static let sample = PreviewData.quantitySamples(for: .bodyMass, count: 1, in: 117.0...125.0).first!
    
    static var previews: some View {
        ForEach(["en", "es"], id: \.self) { localeIdentifier in
            NavigationView {
                FoodItemForm(PreviewData.Food.mayonnaise)
                    .environment(\.locale, .init(identifier: localeIdentifier))
                    .environment(\.editMode, .constant(.inactive))
            }
            
            .previewDisplayName("Locale: \(localeIdentifier)")
        }
    }
}
#endif
