import Foundation

protocol MappedAdapter {
    associatedtype Source: Hashable
    associatedtype Destination
    
    static func value(mappedTo source: Source) -> Destination
}


