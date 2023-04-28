import Foundation


enum ManagedObjectAdapter {
    
    enum SampleQuantityAdapter: Adapter {
        static func value(mappedTo source: SampleQuantityMO) -> SampleQuantity {
            // TODO: use Wrapped Value
        }
        
        typealias Source = SampleQuantityMO
        typealias Destination = SampleQuantity
        
        
    }
    
}


