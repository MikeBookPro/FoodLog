import SwiftUI

struct SummaryView<Editor: EditorViewRepresentable>: View where Editor.Model == SampleQuantity {
    @State private var viewModel: SummaryView.ViewModel<Editor>
    
    init(samples: [SampleQuantity], @ViewBuilder editorView: @escaping (Editor.Model) -> Editor) {
        self._viewModel = .init(initialValue: .init(samples: samples, editorBuilder: editorView))
    }
    
    var body: some View {
        NavigationView {
            List(selection: $viewModel.selected) {
                ForEach(viewModel.samples, id: \.self) { sample in
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
            .navigationTitle(viewModel.navigationTitle)
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
extension SummaryView {
    private struct ViewModel<Editor: EditorViewRepresentable>where Editor.Model == SampleQuantity {
        let samples: [SampleQuantity]
        let editorBuilder: (Editor.Model) -> Editor
        var selected: SampleQuantity? = nil
        var isShowingEditor: Bool = false
        
        let navigationTitle = "Summary"
        
        @ViewBuilder
        func buildEditorView() -> some View {
            NavigationView {
                editorBuilder(selected ?? .template(for: .bodyMass))
                    .navigationTitle("\(selected == nil ? "New" : "Edit") Sample")
            }
        }
        
        func didSwipeDelete(rowsAt offsets: IndexSet) {
            let targetedIDs: [UUID] = offsets.compactMap { samples[$0].id }
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
}

// MARK: - Preview
#if DEBUG
struct ActivitySummaryList_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView(
            samples: PreviewData.quantitySamples(for: .bodyMass, count: 10, in: 95.0...125.0),
            editorView: SampleQuantityForm.init(_:)
        )
    }
}
#endif
