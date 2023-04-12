import Foundation

public typealias DateRange = (start: Date?, end: Date?)

public protocol DateRangeReadable {
    var dateRange: DateRange { get }
}
