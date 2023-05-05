import Foundation

struct Brand {
    let id: UUID?
    let name: String
    
    init(id: UUID? = nil, name: String) {
        self.id = id
        self.name = name
    }
    
    static let generic: Brand = .init(id: .generic, name: "Generic")
}
