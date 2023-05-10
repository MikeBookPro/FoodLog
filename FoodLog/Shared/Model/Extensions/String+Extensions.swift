import Foundation

extension String {
    static let empty: Self = ""
    
    var abbreviatedDate: Date {
        do {
            return try Date.FormatStyle(date: .abbreviated, time: .omitted).parse(self)
        } catch {
            return .now
        }
    }
}
