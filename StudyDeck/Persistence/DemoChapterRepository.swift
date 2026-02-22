import CoreData
import Foundation

final class DemoChapterRepository {
    private let persistenceController: PersistenceController

    init(persistenceController: PersistenceController) {
        self.persistenceController = persistenceController
    }

    func loadDemoChaptersIfNeeded() throws {
        let context = persistenceController.container.viewContext
        let request = ChapterEntity.fetchRequest()
        let count = try context.count(for: request)

        guard count == 0 else { return }

        let chapters = try loadBundledDemoChapters()
        chapters.forEach { chapter in
            let entity = ChapterEntity(context: context)
            entity.update(from: chapter)
        }

        try context.save()
    }

    private func loadBundledDemoChapters() throws -> [Chapter] {
        guard let url = Bundle.main.url(forResource: "chapters", withExtension: "json", subdirectory: "Demo") else {
            return []
        }

        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode([Chapter].self, from: data)
    }
}
