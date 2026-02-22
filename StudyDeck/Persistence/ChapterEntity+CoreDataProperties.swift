import CoreData
import Foundation

extension ChapterEntity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ChapterEntity> {
        NSFetchRequest<ChapterEntity>(entityName: "ChapterEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var section: String?
    @NSManaged public var summary: String?
    @NSManaged public var title: String?
}
