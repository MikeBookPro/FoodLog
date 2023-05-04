import SwiftUI
 
struct HistoricalProgressList: View {
    @State private var viewModel = HistoricalProgressListViewModel()
    @State private var selected: SampleQuantity? = nil
    let samples: [SampleQuantity]
    
    var body: some View {
        NavigationView {
            List(selection: $selected) {
                ForEach(samples, id: \.self) { sample in
                    NavigationLink {
                        MeasurementSampleView(sample: sample, editorToggle: $viewModel.isShowingEditor)
                    } label: {
                        Text(sample.date, format: Date.FormatStyle.init(date: .numeric, time: .shortened))
                        Text(sample.measurement, format: .measurement(width: .abbreviated, numberFormatStyle: .number.precision(.fractionLength(0...2))))
                    }
                    .padding(.vertical, 8)
                }
                .onDelete(perform: didSwipeDelete(rowsAt:))
            }
            .navigationTitle("Progress")
            .fullScreenCover(isPresented: $viewModel.isShowingEditor) {
                NavigationView {
                    if let selected {
                        SampleEditorView(update: selected, onSave: didClickSave(edited:), onCancel: dismissEditor)
                            .navigationTitle("Edit Sample")
                    } else {
                        SampleEditorView(.bodyMass, onSave: didClickSave(new:), onCancel: dismissEditor)
                            .navigationTitle("New Sample")
                    }
                    
                }
            }
            .toolbar {
                ToolbarItem {
                    Button(action: presentEditor, label: { Label("Add Item", systemImage: "plus") })
                }
            }
        }
    }
    
    // MARK: - User Actions
    private func didClickSave(new quantity: SampleQuantity) {
        viewModel.create(sample: quantity)
        dismissEditor()
    }
    
    private func didClickSave(edited quantity: SampleQuantity) {
        viewModel.update(sample: quantity)
        dismissEditor()
    }
    
    private func didSwipeDelete(rowsAt offsets: IndexSet) {
        viewModel.delete(samples, at: offsets)
    }
    
    private func presentEditor() {
        self.viewModel.isShowingEditor = true
    }
    
    private func dismissEditor() {
        self.viewModel.isShowingEditor = false
    }
}

#if DEBUG
struct HistoricalProgressList_Previews: PreviewProvider {
    static var previews: some View {
        HistoricalProgressList(samples: PreviewData.quantitySamples(for: .bodyMass, count: 10, in: 95.0...125.0))
    }
}
#endif
