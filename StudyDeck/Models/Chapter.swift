import Foundation

struct Chapter: Identifiable, Codable, Equatable {
    let id: UUID
    var title: String
    var summary: String
    var section: String

    init(id: UUID = UUID(), title: String, summary: String, section: String) {
        self.id = id
        self.title = title
        self.summary = summary
        self.section = section
    }
}
