import Foundation

struct Sample<T: Identifiable>: Identifiable {
  var id: T.ID { value.id }
  var date: Date
  var value: T

  init(_ value: T, date: Date) {
    self.date = date
    self.value = value
  }
}
