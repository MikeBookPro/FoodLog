//

import SwiftUI

struct MeasurementUnitPicker<NestedPicker: View, Item: Identifiable>: View {
    @State private var viewModel: Self.ViewModel
    
    let nestedPickerBuilder: (Binding<Item?>, [Item]) -> NestedPicker
    
    init(@ViewBuilder dimensionPicker pickerBuilder: @escaping (Binding<Item?>, [Item]) -> NestedPicker) {
        self.viewModel = viewModel
        self.nestedPickerBuilder = pickerBuilder
    }
    
    var body: some View {
        Picker("Unit Type", selection: $viewModel.selectedUnitType) {
            ForEach(viewModel.unitPickerOptions, id: \.self) {
                Text($0.rawValue)
                    .tag($0)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        
        nestedPickerBuilder($viewModel.selectedDimension, viewModel.selectedUnitType.dimensions)
        
        Picker("Unit Type", selection: $viewModel.selectedUnitType) {
            ForEach(viewModel.unitPickerOptions, id: \.self) {
                Text($0.rawValue)
                    .tag($0)
            }
        }
        
    }
}


extension MeasurementUnitPicker {
    enum UnitType: String, CaseIterable {
        case mass = "Mass"
        case length = "Length"
        case volume = "Volume"
        //... Add more as needed
        
        init(unit: Dimension) {
            if Dimension.massDimensions.contains(where: { $0.isEqual(unit) }) {
                self = .mass
            } else if Dimension.lengthDimensions.contains(where: { $0.isEqual(unit) }) {
                self = .length
            } else if Dimension.volumeDimensions.contains(where: { $0.isEqual(unit) }) {
                self = .volume
            } else {
                self = .mass
                
            }
        }
        
        var dimensions: [Dimension] {
            switch self {
                case .mass: return Dimension.massDimensions
                case .length: return Dimension.lengthDimensions
                case .volume: return Dimension.volumeDimensions
            }
        }
    }
    
    struct ViewModel {
        var selectedUnitType: MeasurementUnitPicker.UnitType
        let unitPickerOptions = MeasurementUnitPicker.UnitType.allCases
        
        var selectedDimension: Dimension?
        
        init(dimension: Dimension) {
            selectedUnitType = UnitType(unit: dimension)
            selectedDimension = dimension
        }
    }
}






struct MeasurementDimensionPicker_Previews: PreviewProvider {
    static var previews: some View {
        MeasurementDimensionPicker()
    }
}
