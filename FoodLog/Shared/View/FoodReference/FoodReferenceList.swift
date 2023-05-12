import SwiftUI

struct FoodReferenceList<Editor: EditorViewRepresentable>: View where Editor.Model == FoodItem {
    @State private var editMode: EditMode = .inactive
    @State private var viewModel: EditorListViewModel<Editor>
    
    init(list rowItems: [Editor.Model], @ViewBuilder editorView builder: @escaping (Editor.Model) -> Editor) {
        self._viewModel = .init(initialValue: .init(list: rowItems, editorView: builder))
    }
    
    var body: some View {
        NavigationView {
            List(selection: $viewModel.selected) {
                ForEach(viewModel.rowItems, id: \.self) { rowItem in
                    NavigationLink {
                        viewModel.editorBuilder(rowItem)
                    } label: {
                        Text(rowItem.name)
                    }
                    .padding(.vertical, 8)
                }
//                .onDelete(perform: viewModel.didSwipeDelete(rowsAt:))
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

#if DEBUG
struct FoodReferenceList_Previews: PreviewProvider {
    static var previews: some View {
        FoodReferenceList(
            list: PreviewData.foodItems,
            editorView: FoodItemForm.init(_:)
        )
    }
}
#endif
