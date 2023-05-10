import Foundation

// MARK: - Reference Quantities
protocol QuantityRepresentable: Identifiable, Equatable, Hashable {
    var identifier: QuantityIdentifier { get }
    var measurement: Measurement<Dimension> { get }
    var id: UUID { get }
}

extension QuantityRepresentable {
    static func == (_ lhs: Self, _ rhs: Self) -> Bool { lhs.id == rhs.id }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(identifier)
    }
}



protocol ReferenceQuantityRepresentable: QuantityRepresentable {}
protocol ObservedQuantityRepresentable: QuantityRepresentable {
    var date: Date? { get }
}
//protocol EventSampleRepresentable: QuantityRepresentable {
//    var event: any EventRepresentable { get }
//}

extension ReferenceQuantityRepresentable {
    static func == (_ lhs: any ReferenceQuantityRepresentable, _ rhs: any ReferenceQuantityRepresentable) -> Bool {
        lhs.id == rhs.id && lhs.identifier == rhs.identifier && lhs.measurement == rhs.measurement
    }
}

extension ObservedQuantityRepresentable {
    static func == (_ lhs: any ObservedQuantityRepresentable, _ rhs: any ObservedQuantityRepresentable) -> Bool {
        lhs.id == rhs.id && lhs.identifier == rhs.identifier && lhs.measurement == rhs.measurement && lhs.date == rhs.date
    }
}

// MARK: - Reference Quantities

protocol NutritionInfoRepresentable {
    var servingSize: (any DietaryQuantityRepresentable)? { get }
    var nutrientQuantities: [any DietaryQuantityRepresentable] { get }
}

protocol DietaryQuantityRepresentable: ReferenceQuantityRepresentable {
    var nutritionInfo: (any NutritionInfoRepresentable)? { get }
}

// MARK: - Event Sample Representable

// MARK: - Timestamped Quantities

//TODO: Will need to make a bunch of different SampleQuantity (probably)
protocol SampleQuantityRepresentable: ReferenceQuantityRepresentable, Equatable, Hashable {
    var date: Date { get }
}
