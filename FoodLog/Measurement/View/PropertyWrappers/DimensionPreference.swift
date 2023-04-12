import SwiftUI

@propertyWrapper
struct DimensionPreference<UnitType: Dimension>: DynamicProperty {
    var wrappedValue: QuantityIdentifier
    
    var projectedValue: UnitType {
        QuantityIdentifierToDimensionAdapter.value(mappedTo: wrappedValue)
    }
    
    func update() { return }
}
#if DEBUG

private struct DimensionPreferenceView: View {
    
    @DimensionPreference<Dimension>
    var identifier: QuantityIdentifier
    
    var body: some View {
        VStack {
            LabeledContent("ID") {
                Text(identifier.id).font(.caption)
            }
            LabeledContent("Base Unit") {
                Text(type(of: $identifier).baseUnit().symbol)
            }
            LabeledContent("Preferred Unit") {
                Text($identifier.symbol)
            }
        }
    }
}

struct DimensionPreferenceView_Previews: PreviewProvider {
    static var previews: some View {
        List(QuantityIdentifier.allCases) {
            DimensionPreferenceView(identifier: $0)
        }
    }
}

#endif
