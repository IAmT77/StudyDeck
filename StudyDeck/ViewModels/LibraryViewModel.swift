import CoreData
import Foundation

final class LibraryViewModel: ObservableObject {
    @Published private(set) var chapters: [Chapter] = []
    @Published var selectedSection: String?
    @Published var selectedChapterID: UUID?
    @Published var isDemoModeEnabled = false {
        didSet {
            guard isDemoModeEnabled else { return }
            enableDemoMode()
        }
    }

    private let context: NSManagedObjectContext
    private let demoRepository: DemoChapterRepository

    init(context: NSManagedObjectContext, demoRepository: DemoChapterRepository) {
        self.context = context
        self.demoRepository = demoRepository
        fetchChapters()
    }

    var sections: [String] {
        Array(Set(chapters.map(\.section))).sorted()
    }

    var filteredChapters: [Chapter] {
        guard let selectedSection else { return chapters }
        return chapters.filter { $0.section == selectedSection }
    }

    func fetchChapters() {
        let request = ChapterEntity.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \ChapterEntity.section, ascending: true),
            NSSortDescriptor(keyPath: \ChapterEntity.title, ascending: true)
        ]

        do {
            chapters = try context.fetch(request).map { $0.toChapter() }
            if selectedSection == nil {
                selectedSection = sections.first
            }
        } catch {
            chapters = []
        }
    }

    func selectedChapter() -> Chapter? {
        guard let selectedChapterID else { return filteredChapters.first }
        return filteredChapters.first(where: { $0.id == selectedChapterID })
    }

    private func enableDemoMode() {
        do {
            try demoRepository.loadDemoChaptersIfNeeded()
            fetchChapters()
        } catch {
            // keep existing user state if loading fails
        }
    }
}
