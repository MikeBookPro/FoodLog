import Foundation

protocol ImplementationWrapper {
    associatedtype Wrapped
    var wrapped: Wrapped { get }
}

extension ImplementationWrapper where Self: QuantityRepresentable, Wrapped: QuantityRepresentable {
    var identifier: QuantityIdentifier { wrapped[keyPath: \.identifier] }
    
    var id: UUID? { wrapped[keyPath: \.id] }
    
    var measurement: Measurement<Dimension> { wrapped[keyPath: \.measurement] }
}

extension ImplementationWrapper where Self: SampleQuantityRepresentable, Wrapped: SampleQuantityRepresentable {
    var date: Date { wrapped[keyPath: \.date] }
}
