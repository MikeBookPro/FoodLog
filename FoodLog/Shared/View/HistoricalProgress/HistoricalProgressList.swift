import SwiftUI

struct HistoricalProgressList<Editor: EditorViewRepresentable>: View where Editor.Model == SampleQuantity {
    @State private var viewModel = HistoricalProgressListViewModel()
    @State private var selected: SampleQuantity? = nil
    @State private var isShowingEditor: Bool = false
    
    let samples: [SampleQuantity]
    let editorBuilder: (Editor.Model) -> Editor
    
    init(samples: [SampleQuantity], @ViewBuilder editorView: @escaping (Editor.Model) -> Editor) {
        self.samples = samples
        self.editorBuilder = editorView
    }
    
    var body: some View {
        NavigationView {
            List(selection: $selected) {
                ForEach(samples, id: \.self) { sample in
                    NavigationLink {
                        MeasurementSampleView(sample: sample, editorToggle: $isShowingEditor)
                    } label: {
                        Text(sample.date, format: Date.FormatStyle.init(date: .numeric, time: .shortened))
                        Text(sample.measurement, format: .measurement(width: .abbreviated, numberFormatStyle: .number.precision(.fractionLength(0...2))))
                    }
                    .padding(.vertical, 8)
                }
                .onDelete(perform: didSwipeDelete(rowsAt:))
            }
            .navigationTitle("Progress")
            
            .fullScreenCover(isPresented: $isShowingEditor) {
                NavigationView {
                    editorBuilder(selected ?? .template(for: .bodyMass))
                        .navigationTitle("\(selected == nil ? "New" : "Edit") Sample")
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: presentEditor, label: { Label("Add Item", systemImage: "plus") })
                }
            }
        }
    }
    
    // MARK: - User Actions
    private func didSwipeDelete(rowsAt offsets: IndexSet) {
        viewModel.delete(samples, at: offsets)
    }

    private func presentEditor() {
        isShowingEditor = true
    }
}

#if DEBUG
struct HistoricalProgressList_Previews: PreviewProvider {
    static var previews: some View {
        HistoricalProgressList(
            samples: PreviewData.quantitySamples(for: .bodyMass, count: 10, in: 95.0...125.0),
            editorView: SampleQuantityForm.init(_:)
        )
    }
}
#endif
