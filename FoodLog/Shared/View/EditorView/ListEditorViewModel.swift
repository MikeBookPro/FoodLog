import Foundation
import SwiftUI

protocol EditableListViewModel {
    associatedtype Editor: EditorViewRepresentable
    var rowItems: [Editor.Model] { get }
    var editorBuilder: (Editor.Model) -> Editor { get }
    var selected: Editor.Model? { get set }
    var isShowingEditor: Bool { get set }

    @ViewBuilder
    func buildEditorView() -> NavigationView<Editor>

    init(list rowItems: [Editor.Model], editorView builder: @escaping (Editor.Model) -> Editor)

}

extension EditableListViewModel {

    func buildEditorView() -> NavigationView<Editor> {
        return NavigationView {
            editorBuilder(selected ?? .template(for: .food))
                .environment(\.editMode, .constant(.transient)) as! Self.Editor

        }
    }
}

struct EditorListViewModel<Editor: EditorViewRepresentable>: EditableListViewModel {
    let rowItems: [Editor.Model]
    let editorBuilder: (Editor.Model) -> Editor
    var selected: Editor.Model?
    var isShowingEditor: Bool = false

    init(list rowItems: [Editor.Model], editorView builder: @escaping (Editor.Model) -> Editor) {
        self.rowItems = rowItems
        self.editorBuilder = builder
    }
}
