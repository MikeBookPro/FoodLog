import Foundation

protocol Adapter {
    associatedtype Source: Hashable
    associatedtype Destination

    static func value(mappedTo source: Source) -> Destination
}
