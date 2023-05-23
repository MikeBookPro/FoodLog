import SwiftUI

// MARK: - View
struct MeasurementPickerHost<UnitView: View, DimensionView: View, LabelView: View>: View {
  @State private var viewModel: MeasurementPickerHostViewModel
  @Binding var boundMeasure: Measurement<Dimension>

  private let unitViewBuilder: (UnitType) -> UnitView
  private let dimensionViewBuilder: (Dimension) -> DimensionView
  private let labelBuilder: () -> LabelView

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
    selected measure: Binding<Measurement<Dimension>>,
    keyPaths toTextFor: (unitType: KeyPath<UnitType, String>, dimension: KeyPath<Dimension, String>),
    @ViewBuilder labelView labelBuilder: @escaping () -> LabelView
  ) where UnitView == Text, DimensionView == Text {
    self.init(selected: measure) {
      Text($0[keyPath: toTextFor.unitType])
    } dimensionView: {
      Text($0[keyPath: toTextFor.dimension])
    } labelView: {
      labelBuilder()
    }
  }

  init(
    _ label: String? = nil,    selected measure: Binding<Measurement<Dimension>>,
    @ViewBuilder unitView: @escaping (UnitType) -> UnitView,
    @ViewBuilder dimensionView: @escaping (Dimension) -> DimensionView
  ) where LabelView == Text {
    self.init(selected: measure, unitView: unitView, dimensionView: dimensionView) { Text(label ?? "") }
  }

  init(
    selected measure: Binding<Measurement<Dimension>>,
    @ViewBuilder unitView: @escaping (UnitType) -> UnitView,
    @ViewBuilder dimensionView: @escaping (Dimension) -> DimensionView,
    @ViewBuilder labelView: @escaping () -> LabelView
  ) {
    _viewModel = .init(initialValue: .init(selected: measure.wrappedValue))
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
    ForEach(viewModel.selectedUnitType.dimensions, id: \.self) { dimension in
      dimensionViewBuilder(dimension)
        .tag(Measurement(value: self.boundMeasure.value, unit: dimension))
    }
  }

  var body: some View {
    Group {
      Picker(selection: $viewModel.selectedUnitType, content: unitTypePickerContent) { EmptyView() }
        .labelsHidden()
        .pickerStyle(SegmentedPickerStyle())

      Picker(selection: $viewModel.selectedMeasure, content: dimensionPickerContent) {
        labelBuilder()
      }
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
  let availableUnitTypes = UnitType.allCases
  var selectedUnitType: UnitType
  var selectedMeasure: Measurement<Dimension>
  var lastSelections = UnitType.allCases.reduce(into: [UnitType: Dimension]()) { partialResult, unitType in
    partialResult[unitType] = unitType.baseUnit
  }

  init(selected measure: Measurement<Dimension>) {
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
            MeasurementPickerHost(selected: $measure) { unitType in
              Text(unitType.rawValue)
                .font(.title)
            } dimensionView: { dimension in
              Text(dimension.symbol)
                .font(.caption2)
                .tag(Measurement(value: measure.value, unit: dimension))
            } labelView: {
              Text("Custom Label")
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
