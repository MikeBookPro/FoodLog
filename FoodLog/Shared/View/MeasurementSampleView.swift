//

import SwiftUI

struct MeasurementSampleView: View {
  @Binding var isShowingEditor: Bool
  private let id: UUID?
  private let identifier: QuantityIdentifier
  private let measurement: Measurement<Dimension>
  private let date: Date

  init(sample: some SampleQuantityRepresentable, editorToggle isShowingEditor: Binding<Bool>) {
    self._isShowingEditor = isShowingEditor
    self.id = sample.id
    self.identifier = sample.identifier
    self.measurement = sample.measurement
    self.date = sample.date
  }

  var body: some View {
    VStack {
      if let id {
        LabeledContent("ID") {
          Text(id.uuidString)
            .font(.body)
        }
      }

      LabeledContent("Weight") {
        Text(measurement, format: .measurementStyle)
          .font(.body)
      }

      LabeledContent("Date") {
        Text(date, format: .dateOnlyStyle)
        .font(.body)
      }

      LabeledContent("Time") {
        Text(date, format: .timeOnlyStyle)
        .font(.body)
      }
    }
    .font(.headline)
    .padding()
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Button {
          self.isShowingEditor.toggle()
        } label: {
          Text("Edit")
        }
      }
    }
  }
}

struct MeasurementSampleView_Previews: PreviewProvider {
  private static let bodyWeightSample = SampleQuantity(
    quantity: .init(
      identifier: .bodyMass,
      measurement: .init(value: 124.0123456789, unit: IdentifierToDimensionAdapter.value(mappedTo: .bodyMass))
    ),
    date: .now
  )

  static var previews: some View {
    MeasurementSampleView(sample: bodyWeightSample, editorToggle: .constant(false))
  }
}
