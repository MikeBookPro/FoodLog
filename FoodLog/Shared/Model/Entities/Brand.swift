import Foundation

struct Brand: Identifiable {
  let id: UUID
  let name: String

  init(id: UUID? = nil, name: String) {
    self.id = id ?? UUID()
    self.name = name
  }

  static let generic: Brand = .init(id: .generic, name: "Generic")
}
