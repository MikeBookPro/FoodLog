import Foundation

extension Date {
  var abbreviatedDateString: String {
    self.formatted(date: .abbreviated, time: .omitted)
  }
}
