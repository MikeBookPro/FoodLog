//

import SwiftUI
import CoreData

struct WeightHistoryView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \BodyQuantitySampleMO.startDate, ascending: true)],
        animation: .default
    )
    private var samples: FetchedResults<BodyQuantitySampleMO>
    
    private typealias Sample = MeasurementSample<IdentifiedMeasurement<BodyMeasurementQuantityType, UnitMass>>
    
    @State private var isAddingNewSample: Bool = false
    @State private var digits: (Int, Int, Int, Int) = (0, 0, 0, 0)
    private var newMeasure: String { "\(digits.0)\(digits.1)\(digits.2).\(digits.3)" }
    
    private func dateText(for sample: BodyQuantitySampleMO) -> some View {
        Text("Date: ").font(.headline) + Text(sample.startDate ?? .now, format: .dateTime.day().month(.wide).year())
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(samples) { sample in
                    LabeledContent {
                        if let measurement = sample.measurement as? Measurement<Dimension> {
                            Text(measurement, format: .measurement(width: .abbreviated, numberFormatStyle: .number.precision(.fractionLength(0...2))))
                        }
                    } label: {
                        Text(sample.startDate ?? .now, format: .dateTime.day().month(.wide).year())
                    }
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
            .sheet(isPresented: $isAddingNewSample) {
                SampleEditorView<Sample>(onSave: editorDidSave(sample:)) {
                    isAddingNewSample.toggle()
                }
                .presentationDetents([.medium])
            }
        }
    }
    
    private func editorDidSave(sample: Sample) {
        withAnimation {
            isAddingNewSample.toggle()
            let builder = QuantityTypeBuilder(context: viewContext)
            builder.weight(sampleFrom: sample)
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
        

    private func addItem() {
        withAnimation {
            guard let value = Double(newMeasure) else { return }
            digits = (0, 0, 0, 0)
            let newSample: IdentifiedMeasurement<BodyMeasurementQuantityType, UnitMass> = .init(identifier: .bodyMass, measurement: .init(value: value, unit: .kilograms))
            let builder = QuantityTypeBuilder(context: viewContext)
            builder.weightMeasurement(from: newSample)
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { samples[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
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
