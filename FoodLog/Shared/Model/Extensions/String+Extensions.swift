import Foundation

extension String {
    var abbreviatedDate: Date {
        do {
            return try Date.FormatStyle(date: .abbreviated, time: .omitted).parse(self)
        } catch {
            return .now
        }
    }
}
