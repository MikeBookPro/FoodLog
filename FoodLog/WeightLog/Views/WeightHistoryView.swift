//

import SwiftUI
import CoreData

extension IdentifiedMeasurementMO {
    var measurement: Measurement<Dimension>? {
        guard let dimension = DimensionIdentifier(baseUnitSymbol: self.measurementUnit) else { return nil }
        return MeasurementFactory.measurement(forDimension: dimension, value: self.measurementValue)
    }
}

 
struct WeightHistoryView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \BodyQuantitySampleMO.date, ascending: false)],
        animation: .default
    )
    private var samples: FetchedResults<BodyQuantitySampleMO>
    
    @State private var isShowingEditor: Bool = false
    @State private var selection: BodyQuantitySampleMO? = nil
    
    private let adapt = BodyWeightSampleAdapter.adapt(sampleQuantity:)

    var body: some View {
        NavigationView {
            List {
                ForEach(samples) { sample in
                    NavigationLink {
                        MeasurementSampleView(sample: adapt(sample), editorToggle: $isShowingEditor)
                    } label: {
                        LabeledContent("\((sample.date ?? .distantPast).formatted(date: .abbreviated, time: .shortened))") {
                            if let measurement = sample.measurement {
                                Text(measurement, format: .measurement(width: .abbreviated, numberFormatStyle: .number.precision(.fractionLength(0...2))))
                            }
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Progress")
            .fullScreenCover(isPresented: $isShowingEditor) {
                NavigationView {
                    if let selection {
                        SampleEditorView(update: adapt(selection), onSave: editorDidUpdate(sample:), onCancel: editorDidCancel)
                            .navigationTitle("Edit Sample")
                    } else {
                        SampleEditorView<BodyWeightSample>(.bodyMass, onSave: editorDidUpdate(sample:), onCancel: editorDidCancel)
                            .navigationTitle("New Sample")
                    }
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
    
    private func editorDidUpdate(sample: BodyWeightSample) {
        withAnimation {
            selection = nil
            let manager = DataManager(context: viewContext)
            Task.detached {
                await manager.upsert(sample: sample)
            }
        }
    }
    
    private func editorDidCreate(sample: BodyWeightSample) {
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
            let objects: [BodyQuantitySampleMO] = offsets.map { samples[$0] }
            let weightSamples: [BodyWeightSample] = objects.map { BodyWeightSampleAdapter.adapt(sampleQuantity: $0) }
            let manager = DataManager(context: viewContext)
            Task.detached {
                await withTaskGroup(of: Bool.self) { taskGroup in
                    for sample in weightSamples {
                        taskGroup.addTask {
                            await manager.delete(sample: sample)
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
