import SwiftUI

@propertyWrapper
struct Dimensioned: DynamicProperty {
  var wrappedValue: QuantityIdentifier

  var projectedValue: Dimension {
    IdentifierToDimensionAdapter.value(mappedTo: wrappedValue)
  }
}

#if DEBUG
private struct DimensionView: View {
  @Dimensioned var identifier: QuantityIdentifier

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
      DimensionView(identifier: $0)
    }
  }
}
#endif
