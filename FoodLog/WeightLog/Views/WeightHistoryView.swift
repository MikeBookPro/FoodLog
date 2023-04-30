import SwiftUI
import CoreData

 
struct WeightHistoryView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var isShowingEditor: Bool = false
    @State private var selection: (any SampleQuantityRepresentable)?
    
    private let adapt = BodyWeightSampleAdapter.adapt(sampleQuantity:)

    var body: some View {
        NavigationView {
            SampleQuantitiesView { samples in
                List(selection: $selection) {
                    ForEach(samples, id: \.id) { sample in
                        NavigationLink {
                            MeasurementSampleView(sample: sample, editorToggle: $isShowingEditor)
                        } label: {
                            Text(sample.date, format: Date.FormatStyle.init(date: .numeric, time: .shortened))
                            Text(sample.measurement, format: .measurement(width: .abbreviated, numberFormatStyle: .number.precision(.fractionLength(0...2))))
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
            }
            .navigationTitle("Progress")
            .fullScreenCover(item: $selection) { selection in
                NavigationView {
                    SampleEditorView(update: selection, onSave: editorDidUpdate(sample:), onCancel: editorDidCancel)
                        .navigationTitle("Edit Sample")
                }
            }
            .fullScreenCover(isPresented: $isShowingEditor) {
                NavigationView {
                    SampleEditorView(.bodyMass, onSave: editorDidCreate(sample:), onCancel: editorDidCancel)
                        .navigationTitle("New Sample")
//                    if let selectionID, let selection = samples.first(where: { $0.id == selectionID }) {
//                        SampleEditorView(update: adapt(selection), onSave: editorDidUpdate(sample:), onCancel: editorDidCancel)
//                            .navigationTitle("Edit Sample")
//                    } else {
//                        SampleEditorView(.bodyMass, onSave: editorDidCreate(sample:), onCancel: editorDidCancel)
//                            .navigationTitle("New Sample")
//                    }
                }
            }
            .toolbar {
                ToolbarItem {
                    Button { isShowingEditor.toggle() } label: {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        }
    }
    
    private func editorDidUpdate(sample: SampleQuantity) {
        withAnimation {
            selection = nil
            isShowingEditor.toggle()
            let manager = DataManager(context: viewContext)
            Task.detached {
                await manager.upsert(sample: sample)
            }
        }
    }
    
    private func editorDidCreate(sample: SampleQuantity) {
        withAnimation {
            isShowingEditor.toggle()
            let manager = DataManager(context: viewContext)
            Task.detached {
                await manager.create(sample: sample)
            }
        }
    }
    
    private func editorDidCancel() {
        withAnimation {
            isShowingEditor.toggle()
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            let objects: [SampleQuantityMO] = offsets.map { samples[$0] }
            let weightSamples: [SampleQuantity] = objects.map { BodyWeightSampleAdapter.adapt(sampleQuantity: $0) }
            let manager = DataManager(context: viewContext)
            Task.detached {
                await withTaskGroup(of: Bool.self) { taskGroup in
                    for sample in weightSamples {
                        taskGroup.addTask {
                            await manager.delete(sample: sample, shouldSave: true)
                        }
                    }
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
