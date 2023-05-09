import SwiftUI
//struct FoodItemForm: EditorViewRepresentable {
struct FoodItemForm {
    typealias Model = FoodItem
    
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel: Self.ViewModel
    
    init(_ model: FoodItem) {
        _viewModel = .init(initialValue: ViewModel(foodItem: model))
    }
    
    var body: some View {
        Form {
            Text("TODO: Implement Editor")
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem.cancel(id: "FoodItemForm.toolbar.cancel", action: didClickCancel)
            ToolbarItem.save(id: "FoodItemForm.toolbar.save", action: didClickSave)
        }
    }
    
    func didClickSave() {
        viewModel.user(didTap: .save)
        dismiss()
    }
    
    func didClickCancel() {
        viewModel.user(didTap: .cancel)
        dismiss()
    }
}

// MARK: - View Model
extension FoodItemForm {
//    private struct ViewModel<Toolbar> where Toolbar: ToolbarContent {
    private struct ViewModel {
        enum TapTarget { case cancel, save }
        
        let foodItem: FoodItem
        
        // func toolbar<Content>(@ToolbarContentBuilder content: () -> Content) -> some View where Content : ToolbarContent
        
        func user(didTap target: TapTarget) {
            switch target {
                case .cancel:
                    print("TODO: Cancel")
                case .save:
                    print("TODO: Save")
            }
            
        }
    }
}

#if DEBUG
struct FoodItemForm_Previews: PreviewProvider {
    static let sample = PreviewData.quantitySamples(for: .bodyMass, count: 1, in: 117.0...125.0).first!
    
    static var previews: some View {
        NavigationView {
//            FoodItemForm(sample)
        }
        
    }
}
#endif
