import SwiftUI

@main
struct StudyDeckApp: App {
    @StateObject private var settings = AppSettingsViewModel()
    @StateObject private var libraryViewModel: LibraryViewModel

    init() {
        let persistenceController = PersistenceController.shared
        let demoRepository = DemoChapterRepository(persistenceController: persistenceController)
        _libraryViewModel = StateObject(wrappedValue: LibraryViewModel(
            context: persistenceController.container.viewContext,
            demoRepository: demoRepository
        ))
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(settings)
                .environmentObject(libraryViewModel)
                .preferredColorScheme(settings.colorScheme)
        }
    }
}
