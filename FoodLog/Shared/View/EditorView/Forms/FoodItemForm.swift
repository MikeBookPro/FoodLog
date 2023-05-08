import SwiftUI

struct FoodItemForm: EditorViewRepresentable {
    @Environment(\.dismiss) private var dismiss
    
    private let foodItem: FoodItem
    
    init(_ model: FoodItem) {
        self.foodItem = model
    }
    
    var body: some View {
        Text("TODO")
    }
    
    func didClickSave() {
        print("TODO")
    }
    
    func didClickCancel() {
        print("TODO")
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
