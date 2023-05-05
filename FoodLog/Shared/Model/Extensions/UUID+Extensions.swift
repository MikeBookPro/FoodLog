import Foundation

extension UUID {
    static let generic: UUID = .init(uuidString: "00000000-0000-0000-0000-000000000001") ?? .init()
}
