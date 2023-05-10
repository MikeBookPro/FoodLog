import SwiftUI

struct FoodReferenceList<Editor: EditorViewRepresentable>: View where Editor.Model == FoodItem {
    @State private var viewModel: FoodReferenceList.ViewModel
    
//    init(foodItems: [FoodItem], @ViewBuilder editorView: @escaping (Editor.Model) -> Editor) {
//        self._viewModel = .init(initialValue: .)
//    }
    init(list rowItems: [Editor.Model], @ViewBuilder editorView builder: @escaping (Editor.Model) -> Editor) {
        self._viewModel = .init(initialValue: .init(list: rowItems, editorView: builder))
    }
    
    var body: some View {
        NavigationView {
            List {
                Text("Food Reference")
                    .font(.headline)
            }
            .navigationTitle("Food Reference")
            .sheet(isPresented: $viewModel.isShowingEditor, content: viewModel.buildEditorView)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { viewModel.isShowingEditor = true }, label: { Label("Add Item", systemImage: "plus") })
                }
            }
        }
    }
}

// MARK: - View Model
extension FoodReferenceList {
    private struct ViewModel: EditableListViewModel where Editor.Model == FoodItem {
        let rowItems: [Editor.Model]
        let editorBuilder: (Editor.Model) -> Editor
        var selected: Editor.Model? = nil
        var isShowingEditor: Bool = false
        
        init(list rowItems: [Editor.Model], editorView builder: @escaping (Editor.Model) -> Editor) {
            self.rowItems = rowItems
            self.editorBuilder = builder
        }
    }
}

#if DEBUG
//struct FoodReferenceList_Previews: PreviewProvider {
//    static var previews: some View {
//        FoodReferenceList()
//    }
//}
#endif
