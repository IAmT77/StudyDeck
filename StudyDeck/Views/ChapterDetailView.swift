import SwiftUI

struct ChapterDetailView: View {
    let chapter: Chapter?

    var body: some View {
        Group {
            if let chapter {
                VStack(alignment: .leading, spacing: 12) {
                    Text(chapter.title)
                        .font(.largeTitle)
                    Text(chapter.section)
                        .font(.title3)
                        .foregroundStyle(.secondary)
                    Divider()
                    Text(chapter.summary)
                    Spacer()
                }
                .padding()
            } else {
                ContentUnavailableView("No Chapter Selected", systemImage: "book.closed")
            }
        }
    }
}
