//

import SwiftUI

struct MeasurementUnitPicker: View {
    private let unitTypeOptions = MeasurementUnitPicker.UnitType.allCases
    @State private var selectedUnitType: MeasurementUnitPicker.UnitType
    @Binding var selectedDimension: Dimension
    
    init(selectedDimension: Binding<Dimension>) {
        let unitType = MeasurementUnitPicker.UnitType(unit: selectedDimension.wrappedValue)
        self._selectedDimension = selectedDimension
        self._selectedUnitType = .init(initialValue: unitType)
        
    }
    
    var body: some View {
        Picker("Unit Type", selection: $selectedUnitType) {
            ForEach(unitTypeOptions, id: \.self) {
                Text($0.rawValue)
                    .tag($0)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        
        Picker("Dimension", selection: $selectedDimension) {
            ForEach(selectedUnitType.dimensions, id: \.self) {
                Text($0.symbol)
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
}





#if DEBUG
struct MeasurementDimensionPicker_Previews: PreviewProvider {
    private struct Shim: View {
        @State private var dimension: Dimension = UnitMass.grams
        
        var body: some View {
            NavigationView {
                Form {
                    LabeledContent("Dimension") {
                        Text(dimension.symbol)
                    }
                    
                    MeasurementUnitPicker(selectedDimension: $dimension)
                }
            }
            
        }
    }
    
    static var previews: some View {
        Shim()
    }
}
#endif
