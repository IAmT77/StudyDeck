import XCTest
@testable import StudyDeck

final class StudyDeckTests: XCTestCase {
    func testThemeColorSchemeMapping() {
        XCTAssertNil(AppTheme.system.colorScheme)
        XCTAssertEqual(AppTheme.light.colorScheme, .light)
        XCTAssertEqual(AppTheme.dark.colorScheme, .dark)
    }

    func testLibraryFiltersBySelectedSection() {
        let persistence = PersistenceController(inMemory: true)
        let demoRepo = DemoChapterRepository(persistenceController: persistence)
        let viewModel = LibraryViewModel(context: persistence.container.viewContext, demoRepository: demoRepo)

        let first = ChapterEntity(context: persistence.container.viewContext)
        first.update(from: Chapter(title: "A", summary: "S", section: "One"))
        let second = ChapterEntity(context: persistence.container.viewContext)
        second.update(from: Chapter(title: "B", summary: "S", section: "Two"))

        try? persistence.container.viewContext.save()
        viewModel.fetchChapters()
        viewModel.selectedSection = "Two"

        XCTAssertEqual(viewModel.filteredChapters.count, 1)
        XCTAssertEqual(viewModel.filteredChapters.first?.title, "B")
    }
}
