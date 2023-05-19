import SwiftUI

// MARK: - View
struct MeasurementPickerHost<UnitView: View, DimensionView: View, LabelView: View>: View {
  @State private var viewModel: MeasurementPickerHostViewModel
  @Binding var boundMeasure: Measurement<Dimension>

  private let unitViewBuilder: (UnitType) -> UnitView
  private let dimensionViewBuilder: (Dimension) -> DimensionView
  private let labelBuilder: (String) -> LabelView

  init(
    _ label: String? = nil,
    selected measure: Binding<Measurement<Dimension>>,
    keyPaths toTextFor: (unitType: KeyPath<UnitType, String>, dimension: KeyPath<Dimension, String>)
  ) where LabelView == Text, UnitView == Text, DimensionView == Text {
    self.init(label, selected: measure) {
      Text($0[keyPath: toTextFor.unitType])
    } dimensionView: {
      Text($0[keyPath: toTextFor.dimension])
    }
  }

  init(
    _ label: String? = nil,
    selected measure: Binding<Measurement<Dimension>>,
    @ViewBuilder unitView: @escaping (UnitType) -> UnitView,
    @ViewBuilder dimensionView: @escaping (Dimension) -> DimensionView
  ) where LabelView == Text {
    self.init(label, selected: measure, unitView: unitView, dimensionView: dimensionView) { Text($0) }
  }

  init(
    _ label: String? = nil,
    selected measure: Binding<Measurement<Dimension>>,
    @ViewBuilder unitView: @escaping (UnitType) -> UnitView,
    @ViewBuilder dimensionView: @escaping (Dimension) -> DimensionView,
    @ViewBuilder labelView: @escaping (String) -> LabelView
  ) {
    _viewModel = .init(initialValue: .init(label: label, selected: measure.wrappedValue))
    _boundMeasure = measure
    unitViewBuilder = unitView
    dimensionViewBuilder = dimensionView
    labelBuilder = labelView
  }

  @ViewBuilder
  private func unitTypePickerContent() -> some View {
    ForEach(viewModel.availableUnitTypes, id: \.self, content: unitViewBuilder)
  }

  @ViewBuilder
  private func dimensionPickerContent() -> some View {
    ForEach(viewModel.selectedUnitType.dimensions, id: \.self, content: dimensionViewBuilder)
  }

  @ViewBuilder
  private func labelContent() -> some View {
    if let text = viewModel.labelText {
      labelBuilder(text)
    } else {
      EmptyView()
        .labelsHidden()
    }
  }

  var body: some View {
    Group {
      Picker(selection: $viewModel.selectedUnitType, content: unitTypePickerContent) { EmptyView() }
        .labelsHidden()
        .pickerStyle(SegmentedPickerStyle())

      Picker(selection: $viewModel.selectedMeasure, content: dimensionPickerContent, label: labelContent)
    }
    .onReceive([viewModel].publisher.first()) { vm in
      let (unitType, measure) = (vm.selectedUnitType, vm.selectedMeasure)
      let lastDimension = vm.lastSelections[unitType, default: unitType.baseUnit]
      let didChangeUnitType = !unitType.dimensions.contains(measure.unit)

      if didChangeUnitType {
        self.viewModel.selectedMeasure = .init(value: measure.value, unit: lastDimension)
      } else {
        self.viewModel.lastSelections[unitType] = measure.unit // changed the
        self.boundMeasure = measure.converted(to: measure.unit)
      }
    }
  }
}

// MARK: - View Model
private struct MeasurementPickerHostViewModel {
  let labelText: String?
  let availableUnitTypes = UnitType.allCases
  var selectedUnitType: UnitType
  var selectedMeasure: Measurement<Dimension>
  var lastSelections = UnitType.allCases.reduce(into: [UnitType: Dimension]()) { partialResult, unitType in
    partialResult[unitType] = unitType.baseUnit
  }

  init(label text: String?, selected measure: Measurement<Dimension>) {
    self.labelText = text
    self.selectedUnitType = UnitType(unit: measure.unit)
    self.selectedMeasure = measure
    self.lastSelections[selectedUnitType] = measure.unit
  }
}

// MARK: - Preview
#if DEBUG
struct MeasurementPickerHost_Previews: PreviewProvider {
  private struct Shim: View {
    enum Configuration: String, CaseIterable, Identifiable {
      case customLabel, stringLabel, noLabel
      var id: String { self.rawValue }
    }

    @State private var measure: Measurement<Dimension> = .init(value: 10.0, unit: UnitMass.grams)

    let config: Configuration

    var body: some View {
      VStack {
        switch config {
          case .customLabel:
            MeasurementPickerHost("Custom Label", selected: $measure) { unitType in
              Text(unitType.rawValue)
                .font(.title)
            } dimensionView: { dimension in
              Text(dimension.symbol)
                .font(.caption2)
                .tag(Measurement(value: measure.value, unit: dimension))
              //                                    .tag(UnitMass(value: measurement.value, unit: unit)))
            } labelView: {
              Text($0)
                .font(.largeTitle)
            }

          case .stringLabel:
            MeasurementPickerHost("String Label", selected: $measure) {
              Text($0.rawValue)
                .font(.headline)
            } dimensionView: {
              Text($0.symbol)
                .font(.headline)
            }

          case .noLabel:
            MeasurementPickerHost(selected: $measure, keyPaths: (unitType: \.rawValue, dimension: \.symbol))
        }
      }

      LabeledContent("Selected Dimension", value: measure.unit.symbol)
        .font(.caption2)
    }
  }

  static var previews: some View {
    ForEach(Shim.Configuration.allCases, id: \.self) { config in
      NavigationView {
        List {
          Shim(config: config)
        }
      }
      .previewDisplayName(config.rawValue)
    }
  }
}
#endif
