import SwiftUI
import CoreData
import Combine

class SampleViewModel: ObservableObject {
    @Published var samples = [SampleQuantity]()
    @Published var isShowingEditor: Bool = false
    @Published var selected: SampleQuantity?
    
    private var cancellable: AnyCancellable?
    private let dataStore: DataStore
    
    init(dataStore: DataStore) {
        self.dataStore = dataStore
        self.cancellable = dataStore.$sampleQuantities
            .sink { [weak self] newSampleQuantities in
                self?.samples = newSampleQuantities.values.sorted { $0.date < $1.date }
            }
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    func presentEditor() {
        self.isShowingEditor = true
    }
    func dismissEditor() {
        self.isShowingEditor = false
//        self.selectionID = nil
    }
    
    func create(sample quantity: SampleQuantity) {
        // TODO: Update in CoreData
        let dataStore = self.dataStore
        Task { await dataStore.create(sampleQuantity: quantity) }
        dismissEditor()
    }
    
    func update(sample quantity: SampleQuantity) {
        // TODO: Update in CoreData
        let dataStore = self.dataStore
        Task { await dataStore.update(sampleQuantity: quantity) }
        dismissEditor()
    }
    
    func delete(samplesAt offsets: IndexSet) {
        let targetedIDs: [UUID] = offsets.compactMap { samples[$0].id }
        let dataStore = self.dataStore
        Task {
            await withTaskGroup(of: Void.self) { taskGroup in
                for id in targetedIDs {
                    taskGroup.addTask {
                        await dataStore.delete(sampleQuantityWithID: id)
                    }
                }
            }
        }
    }
}

 
struct WeightHistoryView: View {
    @ObservedObject private var viewModel = SampleViewModel(dataStore: DataStore())

    var body: some View {
        NavigationView {
            List(selection: $viewModel.selected) {
                ForEach(viewModel.samples, id:\.self) { sample in
                    NavigationLink {
                        MeasurementSampleView(sample: sample, editorToggle: $viewModel.isShowingEditor)
                    } label: {
                        Text(sample.date, format: Date.FormatStyle.init(date: .numeric, time: .shortened))
                        Text(sample.measurement, format: .measurement(width: .abbreviated, numberFormatStyle: .number.precision(.fractionLength(0...2))))
                    }
                }
                .onDelete(perform: viewModel.delete(samplesAt:))
            }
            .navigationTitle("Progress")
            .fullScreenCover(isPresented: $viewModel.isShowingEditor) {
                NavigationView {
                    if let selected = viewModel.selected {
                        SampleEditorView(update: selected, onSave: viewModel.update(sample:), onCancel: viewModel.dismissEditor)
                            .navigationTitle("Edit Sample")
                    } else {
                        SampleEditorView(.bodyMass, onSave: viewModel.create(sample:), onCancel: viewModel.dismissEditor)
                            .navigationTitle("New Sample")
                    }
                    
                }
            }
            .toolbar {
                ToolbarItem {
                    Button(action: viewModel.presentEditor, label: { Label("Add Item", systemImage: "plus") })
                }
            }
        }
    }
}


struct WeightHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        WeightHistoryView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
