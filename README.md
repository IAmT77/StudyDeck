# StudyDeck

A macOS 13+ SwiftUI learning app scaffold with MVVM, Core Data persistence, sidebar navigation, theme switching, and Demo Mode sample content.

## Project generation

This repository contains an `XcodeGen` spec (`project.yml`). Generate the Xcode project with:

```bash
xcodegen generate
```

## Run tests (on macOS with Xcode installed)

```bash
xcodebuild test -scheme StudyDeck -destination 'platform=macOS'
```
