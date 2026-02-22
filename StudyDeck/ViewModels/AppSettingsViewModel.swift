import SwiftUI

enum AppTheme: String, CaseIterable, Identifiable {
    case system = "System"
    case light = "Light"
    case dark = "Dark"

    var id: String { rawValue }

    var colorScheme: ColorScheme? {
        switch self {
        case .system: nil
        case .light: .light
        case .dark: .dark
        }
    }
}

final class AppSettingsViewModel: ObservableObject {
    @Published var selectedTheme: AppTheme = .system

    var colorScheme: ColorScheme? {
        selectedTheme.colorScheme
    }
}
