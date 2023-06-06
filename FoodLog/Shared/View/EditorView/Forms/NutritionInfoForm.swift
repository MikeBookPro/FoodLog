//

import SwiftUI

struct NutritionInfoForm: View {
  @Binding var nutritionInfo: NutritionInfo

  var body: some View {
    Section("Serving size") {
      MeasurementForm(measure: $nutritionInfo.servingSize)
    }

    Section("Nutrition info") {
      ForEach(nutritionInfo.nutrientMeasurements.indices, id: \.self) {
        editorRow(at: $0)
      }
    }
  }

  private func editorRow(at index: Int) -> some View {
    let nutrientMeasure = nutritionInfo.nutrientMeasurements[index]
    return EditorRow(
      NutrientNameAdapter.value(mappedTo: nutrientMeasure.healthID),
      editing: $nutritionInfo.nutrientMeasurements[index].measurement,
      readFormat: .measurementStyle
    ) { boundValue in
      TextField("Enter value", value: boundValue.value, format: .twoDecimalMaxStyle)
        .editorRow(decimalStyle: [.decimalInput])

      Text(nutrientMeasure.measurement.unit.symbol)
    }
  }
}

struct NutritionInfoForm_Previews: PreviewProvider {
  private struct ShimForm: View {
    @State private var egg = PreviewData.NutritionInfo.egg

    var body: some View {
      NavigationView {
        Shim(boundValue: $egg)
          .navigationTitle(Text(egg.servingSize, format: .measurementStyle))
      }
    }
  }

  private struct Shim: View {
    @Binding var boundValue: NutritionInfo
    @State var editedValue: NutritionInfo

    init(boundValue: Binding<NutritionInfo>) {
      _boundValue = boundValue
      _editedValue = .init(initialValue: boundValue.wrappedValue)
    }

    var body: some View {
      Form {
        NutritionInfoForm(nutritionInfo: $editedValue)
      }
      .environment(\.editMode, .constant(.active))
      .toolbar {
        ToolbarItem.cancel(id: "\(String(describing: Self.self)).toolbar.cancel", action: didClickCancel)
        ToolbarItem.save(id: "\(String(describing: Self.self)).toolbar.save", action: didClickSave)
      }
    }

    private func didClickSave() {
      boundValue = editedValue
    }

    private func didClickCancel() {
      editedValue = boundValue
    }
  }

  static var previews: some View {
    ShimForm()
  }
}
