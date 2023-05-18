import SwiftUI

// MARK: - View
struct MeasurementPickerHost<UnitView: View, DimensionView: View, LabelView: View>: View {
    @State private var viewModel: MeasurementPickerHostViewModel
    @Binding var boundDimension: Dimension
    
    private let unitViewBuilder: (UnitType) -> UnitView
    private let dimensionViewBuilder: (Dimension) -> DimensionView
    private let labelBuilder: () -> LabelView
    
    init(
        _ label: some StringProtocol,
        selected dimension: Binding<Dimension>,
        keyPaths toTextFor: (unitType: KeyPath<UnitType, String>, dimension: KeyPath<Dimension, String>)
    ) where LabelView == Text, UnitView == Text, DimensionView == Text {
        self.init(label, selected: dimension) {
            Text($0[keyPath: toTextFor.unitType])
        } dimensionView: {
            Text($0[keyPath: toTextFor.dimension])
        }

    }
    
    init(
        _ label: some StringProtocol,
        selected dimension: Binding<Dimension>,
        @ViewBuilder unitView: @escaping (UnitType) -> UnitView,
        @ViewBuilder dimensionView: @escaping (Dimension) -> DimensionView
    ) where LabelView == Text {
        self.init(selected: dimension, unitView: unitView, dimensionView: dimensionView, labelView: { Text(label) })
    }
    
    init(
        selected dimension: Binding<Dimension>,
        @ViewBuilder unitView: @escaping (UnitType) -> UnitView,
        @ViewBuilder dimensionView: @escaping (Dimension) -> DimensionView,
        @ViewBuilder labelView: @escaping () -> LabelView
    ) {
        _viewModel = .init(initialValue: .init(selected: dimension.wrappedValue))
        _boundDimension = dimension
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
    
    var body: some View {
        Group {
            Picker(selection: $viewModel.selectedUnitType, content: unitTypePickerContent, label: { EmptyView() })
                .labelsHidden()
                .pickerStyle(SegmentedPickerStyle())
            
            
            Picker(selection: $viewModel.selectedDimension, content: dimensionPickerContent, label: labelBuilder)
        }
        .onReceive([viewModel].publisher.first()) { vm in
            let (unitType, dimension) = (vm.selectedUnitType, vm.selectedDimension)
            let lastDimension = vm.lastSelections[unitType, default: unitType.baseUnit]
            let didChangeUnitType = !unitType.dimensions.contains(dimension)
            
            if didChangeUnitType {
                self.viewModel.selectedDimension = lastDimension // changed the unit, update the viewModel's selectedDimension
            } else {
                self.viewModel.lastSelections[unitType] = dimension // changed the
                self.boundDimension = dimension
            }
        }
        
    }
}

// MARK: - View Model
private struct MeasurementPickerHostViewModel {
    let availableUnitTypes = UnitType.allCases
    var selectedUnitType: UnitType
    var selectedDimension: Dimension
    var lastSelections: [UnitType: Dimension] = UnitType.allCases.reduce(into: [UnitType: Dimension]()) { (partialResult, unitType) in
        partialResult[unitType] = unitType.baseUnit
    }
    
    init(selected dimension: Dimension) {
        self.selectedUnitType = UnitType(unit: dimension)
        self.selectedDimension = dimension
        self.lastSelections[selectedUnitType] = dimension
    }
}

// MARK: - Preview
#if DEBUG
struct MeasurementPickerHost_Previews: PreviewProvider {
    private struct Shim: View {
        enum Configuration: String, CaseIterable, Identifiable {
            case customLabel, stringLabel, keyPathBody
            var id: String { self.rawValue }
        }
        
        @State private var dimension: Dimension = UnitMass.grams
        
        let config: Configuration
        
        var body: some View {
            VStack {
                switch config {
                    case .customLabel:
                        MeasurementPickerHost(selected: $dimension) { unitType in
                            Text(unitType.rawValue)
                                .font(.title)
                        } dimensionView: { dimension in
                            Text(dimension.symbol)
                                .font(.caption2)
                        } labelView: {
                            Text("Dimension")
                                .font(.largeTitle)
                        }
                        
                    case .stringLabel:
                        MeasurementPickerHost("String Label", selected: $dimension) {
                            Text($0.rawValue)
                                .font(.headline)
                        } dimensionView: {
                            Text($0.symbol)
                                .font(.headline)
                        }
                        
                    case .keyPathBody:
                        MeasurementPickerHost("Text KeyPath", selected: $dimension, keyPaths: (unitType: \.rawValue, dimension: \.symbol))
                }
                
            }
            
            LabeledContent("Selected Dimension", value: dimension.symbol)
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
