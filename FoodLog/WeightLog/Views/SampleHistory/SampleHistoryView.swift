import SwiftUI
 
struct SampleHistoryView: View {
    @ObservedObject private var viewModel = SampleHistoryViewModel(dataStore: DataStore())

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
            .refreshable { viewModel.refresh() }
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
            .onAppear(perform: viewModel.refresh)
        }
    }
}

#if DEBUG
struct WeightHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        SampleHistoryView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
#endif
