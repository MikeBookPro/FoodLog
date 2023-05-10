import SwiftUI

struct SummaryView<Editor: EditorViewRepresentable>: View where Editor.Model == SampleQuantity {
    @State private var viewModel: EditorListViewModel<Editor>
//    @State private var viewModel: SummaryView.ViewModel
    
    init(list rowItems: [SampleQuantity], @ViewBuilder editorView builder: @escaping (Editor.Model) -> Editor) {
        self._viewModel = .init(initialValue: .init(list: rowItems, editorView: builder))
    }
    
    var body: some View {
        NavigationView {
            List(selection: $viewModel.selected) {
                ForEach(viewModel.rowItems, id: \.self) { sample in
                    NavigationLink {
                        MeasurementSampleView(sample: sample, editorToggle: $viewModel.isShowingEditor)
                    } label: {
                        Text(sample.date, format: Date.FormatStyle.init(date: .numeric, time: .shortened))
                        Text(sample.measurement, format: .measurement(width: .abbreviated, numberFormatStyle: .number.precision(.fractionLength(0...2))))
                    }
                    .padding(.vertical, 8)
                }
                .onDelete(perform: viewModel.didSwipeDelete(rowsAt:))
            }
            .navigationTitle("Summary")
            .sheet(isPresented: $viewModel.isShowingEditor, content: viewModel.buildEditorView)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: presentEditor, label: { Label("Add Item", systemImage: "plus") })
                }
            }
        }
    }
    
    // MARK: - User Actions
    private func presentEditor() {
        viewModel.isShowingEditor = true
    }
}

// MARK: - View Model
private extension EditorListViewModel where Editor.Model == SampleQuantity {
    func didSwipeDelete(rowsAt offsets: IndexSet) {
        let targetedIDs: [UUID] = offsets.compactMap { rowItems[$0].id }
        Task {
            await withTaskGroup(of: Void.self) { taskGroup in
                for id in targetedIDs {
                    taskGroup.addTask {
                        await DataManager.shared.delete(sampleWithID: id, shouldSave: true)
                    }
                }
            }
        }
    }
}

// MARK: - Preview
#if DEBUG
struct ActivitySummaryList_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView(
            list: PreviewData.quantitySamples(for: .bodyMass, count: 10, in: 95.0...125.0),
            editorView: SampleQuantityForm.init(_:)
        )
    }
}
#endif
