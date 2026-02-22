import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var settings: AppSettingsViewModel
    @EnvironmentObject private var library: LibraryViewModel

    var body: some View {
        NavigationSplitView {
            List(selection: $library.selectedSection) {
                ForEach(library.sections, id: \.self) { section in
                    Label(section, systemImage: "books.vertical")
                        .tag(Optional(section))
                }
            }
            .navigationTitle("Chapters")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Picker("Theme", selection: $settings.selectedTheme) {
                        ForEach(AppTheme.allCases) { theme in
                            Text(theme.rawValue).tag(theme)
                        }
                    }
                    .pickerStyle(.menu)
                }
            }
        } content: {
            List(selection: $library.selectedChapterID) {
                ForEach(library.filteredChapters) { chapter in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(chapter.title)
                            .font(.headline)
                        Text(chapter.summary)
                            .lineLimit(2)
                            .foregroundStyle(.secondary)
                    }
                    .tag(Optional(chapter.id))
                }
            }
            .navigationTitle(library.selectedSection ?? "Library")
        } detail: {
            ChapterDetailView(chapter: library.selectedChapter())
        }
        .safeAreaInset(edge: .bottom) {
            Toggle("Demo Mode", isOn: $library.isDemoModeEnabled)
                .padding()
                .background(.bar)
        }
    }
}
