import Foundation
import SwiftUI

protocol EditableModel {
    static func template(for identifier: QuantityIdentifier) -> Self
}

protocol EditorViewRepresentable: View {
    associatedtype Model: EditableModel
    
    func create(_ model: Model)
    func update(_ model: Model)
    
    init(_ model: Model)
    
    func didClickSave()
    func didClickCancel()
}

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
        }
    }
}

extension EditorViewRepresentable where Model: SampleQuantityRepresentable {
    
    func create(_ model: Model) {
        Task {
//            await PersistentDataStore.shared.create(sampleQuantity: model)
            await DataManager.shared.create(sample: model)
        }
    }
    
    func update(_ model: Model) {
        Task {
//            await PersistentDataStore.shared.update(sampleQuantity: model)
            await DataManager.shared.upsert(sample: model)
        }
    }
}

extension EditorViewRepresentable where Model == FoodItem {
    
    func create(_ model: Model) {
        print("TODO: implement")
//        Task {
//            await DataManager.shared.create(sample: model)
//        }
    }
    
    func update(_ model: Model) {
        print("TODO: implement")
//        Task {
//            await DataManager.shared.upsert(sample: model)
//        }
    }
    
}
