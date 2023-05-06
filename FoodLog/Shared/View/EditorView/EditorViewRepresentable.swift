import Foundation
import SwiftUI

protocol EditorViewRepresentable: View {
    associatedtype Model
    
    func create(_ model: Model)
    func update(_ model: Model)
    
    init(_ model: Model)
}

extension EditorViewRepresentable where Model: SampleQuantityRepresentable {
    
    func create(_ model: Model) {
        Task {
//            await PersistentDataStore.shared.create(sampleQuantity: model)
            await DataManager.shared.create(sample: model)
        }
    }
    
    func update(_ model: SampleQuantity) {
        Task {
//            await PersistentDataStore.shared.update(sampleQuantity: model)
            await DataManager.shared.upsert(sample: model)
        }
    }
}
