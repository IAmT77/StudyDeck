import CoreData
import Foundation

@objc(ChapterEntity)
public class ChapterEntity: NSManagedObject {
    func toChapter() -> Chapter {
        Chapter(
            id: id ?? UUID(),
            title: title ?? "Untitled",
            summary: summary ?? "",
            section: section ?? "General"
        )
    }

    func update(from chapter: Chapter) {
        id = chapter.id
        title = chapter.title
        summary = chapter.summary
        section = chapter.section
    }
}
