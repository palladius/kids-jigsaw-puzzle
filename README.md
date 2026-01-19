# 🧩 Kids Jigsaw Puzzle Game

![Grid Logo](grid-image.png)

> **Goal**: Create an interactive jigsaw puzzle game for kids where they can use their own photos (family, heroes, etc.) and solve puzzles by swapping tiles. Adjacent correct tiles merge automatically!

* [App on GH PAGES](https://palladius.github.io/kids-jigsaw-puzzle/)


![Example image of Ricc kids](image.png)

## 🚀 Installation

### macOS (Recommended)

1. **Install Dependencies**: Use [just](https://just.systems/) to install Flutter and CocoaPods:
   ```bash
   just install-mac
   ```
2. **Setup Flutter**: Run the setup script to verify installation:
   ```bash
   just setup-mac
   ```
3. **Xcode**: Ensure you have a full installation of Xcode from the App Store. After installation, run:
   ```bash
   sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
   sudo xcodebuild -runFirstLaunch
   ```

### Other Platforms
- **Android**: Install [Android Studio](https://developer.android.com/studio) and the Flutter SDK.
- **Linux**: Install Flutter via snap or manual download.
- **Web**: Flutter SDK is sufficient.
