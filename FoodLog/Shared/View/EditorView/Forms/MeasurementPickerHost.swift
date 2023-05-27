import SwiftUI

// MARK: - View
struct MeasurementPickerHost<UnitTypeView: View, UnitView: View, LabelView: View>: View {
  @State private var viewModel: MeasurementPickerHostViewModel
  @Binding var unit: Dimension

  private let unitTypeViewBuilder: (UnitType) -> UnitTypeView
  private let unitViewBuilder: (Dimension) -> UnitView
  private let labelBuilder: () -> LabelView

  init(
    _ label: String? = nil,
    selected unit: Binding<Dimension>,
    keyPaths toTextFor: (unitType: KeyPath<UnitType, String>, unit: KeyPath<Dimension, String>)
  ) where LabelView == Text, UnitTypeView == Text, UnitView == Text {
    self.init(label, selected: unit) {
      Text($0[keyPath: toTextFor.unitType])
    } unitView: {
      Text($0[keyPath: toTextFor.unit])
    }
  }

  init(
    selected unit: Binding<Dimension>,
    keyPaths toTextFor: (unitType: KeyPath<UnitType, String>, unit: KeyPath<Dimension, String>),
    @ViewBuilder labelView labelBuilder: @escaping () -> LabelView
  ) where UnitTypeView == Text, UnitView == Text {
    self.init(selected: unit) {
      Text($0[keyPath: toTextFor.unitType])
    } unitView: {
      Text($0[keyPath: toTextFor.unit])
    } labelView: {
      labelBuilder()
    }
  }

  init(
    _ label: String? = nil,
    selected unit: Binding<Dimension>,
    @ViewBuilder unitTypeView: @escaping (UnitType) -> UnitTypeView,
    @ViewBuilder unitView: @escaping (Dimension) -> UnitView
  ) where LabelView == Text {
    self.init(selected: unit, unitTypeView: unitTypeView, unitView: unitView) { Text(label ?? "") }
  }

  init(
    selected unit: Binding<Dimension>,
    @ViewBuilder unitTypeView: @escaping (UnitType) -> UnitTypeView,
    @ViewBuilder unitView: @escaping (Dimension) -> UnitView,
    @ViewBuilder labelView: @escaping () -> LabelView
  ) {
    _viewModel = .init(initialValue: .init(selected: unit.wrappedValue))
    _unit = unit
    unitTypeViewBuilder = unitTypeView
    unitViewBuilder = unitView
    labelBuilder = labelView
  }

  @ViewBuilder
  private func unitTypePickerContent() -> some View {
    ForEach(viewModel.availableUnitTypes, id: \.self, content: unitTypeViewBuilder)
  }

  @ViewBuilder
  private func unitPickerContent() -> some View {
    ForEach(viewModel.unitType.dimensions, id: \.self) { dimension in
      unitViewBuilder(dimension) // .tag(Measurement(value: self.boundMeasure.value, unit: dimension))
    }
  }

  var body: some View {
    Group {
      Picker(selection: $viewModel.unitType, content: unitTypePickerContent) { EmptyView() }
        .labelsHidden()
        .pickerStyle(SegmentedPickerStyle())

      Picker(selection: $unit, content: unitPickerContent) {
        labelBuilder()
      }
    }
    .onChange(of: viewModel.unitType) { unitType in
      unit = viewModel.lastSelections[unitType, default: unitType.baseUnit]
    }
    .onChange(of: unit) {
      if viewModel.unitType.dimensions.contains($0) {
        viewModel.lastSelections[viewModel.unitType] = $0
      }
    }
  }
}

// MARK: - View Model
private struct MeasurementPickerHostViewModel {
  let availableUnitTypes = UnitType.allCases
  var unitType: UnitType
  var lastSelections = UnitType.allCases.reduce(into: [UnitType: Dimension]()) { partialResult, unitType in
    partialResult[unitType] = unitType.baseUnit
  }

  init(selected unit: Dimension) {
    self.unitType = UnitType(unit: unit)
    self.lastSelections[unitType] = unit
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

    @State private var value: Double = 10.0
    @State private var unit: Dimension = UnitMass.grams

    let config: Configuration

    var body: some View {
      VStack {
        switch config {
          case .customLabel:
            MeasurementPickerHost(selected: $unit) { unitType in
              Text(unitType.rawValue)
                .font(.title)
            } unitView: { dimension in
              Text(dimension.symbol)
                .font(.caption2) // .tag(Measurement(value: value, unit: dimension))
            } labelView: {
              LabeledContent("Label") {
                TextField("Measurement Value", value: $value, format: .twoDecimalMaxStyle)
                  .textFieldStyle(.roundedBorder)
                  .editorRow(decimalStyle: [.decimalInput])
              }
            }

          case .stringLabel:
            MeasurementPickerHost("String Label", selected: $unit) {
              Text($0.rawValue)
                .font(.headline)
            } unitView: {
              Text($0.symbol)
                .font(.headline)
            }

          case .noLabel:
            MeasurementPickerHost(selected: $unit, keyPaths: (unitType: \.rawValue, unit: \.symbol))
        }
      }

      Group {
        LabeledContent("Selected Dimension", value: unit.symbol)
        LabeledContent("Measurement") {
          Text(Measurement(value: value, unit: unit), format: .measurementStyle)
        }
      }
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
