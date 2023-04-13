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
        sortDescriptors: [NSSortDescriptor(keyPath: \BodyQuantitySampleMO.startDate, ascending: false)],
        animation: .default
    )
    private var samples: FetchedResults<BodyQuantitySampleMO>
    
    @State private var isAddingNewSample: Bool = false
    @State private var selection: BodyQuantitySampleMO? = nil

    var body: some View {
        NavigationView {
            List {
                ForEach(samples) { sample in
                    LabeledContent {
                        if let measurement = sample.measurement {
                            Text(measurement, format: .measurement(width: .abbreviated, numberFormatStyle: .number.precision(.fractionLength(0...2))))
                        } else {
                            Text("measurement: \(sample.measurement?.description ?? "none")")
                        }
                    } label: {
                        if let date = sample.startDate {
                            Text(date, format: .dateTime.day().month(.wide).year())
                        } else {
                            Text("no date")
                        }
                    }
                    .onTapGesture {
                        selection = sample
                    }
//                    .tag(sample)
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
    #if os(iOS)
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
    #endif
                ToolbarItem {
                    Button {
                        isAddingNewSample.toggle()
                    } label: {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .navigationTitle("Weight History")
            .sheet(item: $selection) { selected in
                SampleEditorView<BodyWeightSample>(
                    sample: BodyWeightSampleAdapter.adapt(sampleQuantity: selected),
                    onSave: editorDidUpdate(sample:)
                ) {
                    selection = nil
                }
                .presentationDetents([.medium])
            }
            
            .sheet(isPresented: $isAddingNewSample) {
                SampleEditorView<BodyWeightSample>(.bodyMass, onSave: editorDidCreate(sample:)) {
                    isAddingNewSample.toggle()
                    }
                .presentationDetents([.medium])
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
            isAddingNewSample.toggle()
            let manager = DataManager(context: viewContext)
            Task.detached {
                await manager.create(sample: sample)
            }
            
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
