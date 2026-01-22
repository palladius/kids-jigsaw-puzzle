# 🧩 Kids Jigsaw Puzzle Game v1.1.8

![Grid Logo](grid-image.png)

> **Goal**: Create an interactive jigsaw puzzle game for kids where they can use their own photos (family, heroes, etc.) and solve puzzles by swapping tiles. Adjacent correct tiles merge automatically!

* [App on GH PAGES](https://palladius.github.io/kids-jigsaw-puzzle/)

## ✅ Tested Platforms

* [x] 🍎 **macOS** (v1.1.5)
* [x] 🐧 **Linux**
* [x] 🌐 **Web**
* [ ] 🤖 **Android**
* [ ] 📱 **iOS** ([How to install on iPhone](doc/how-to-install-on-iphone.md))
* [ ] 🪟 **Windows**

![Example image of Ricc kids](image.png)

## ✨ Features
- **Multi-Universe Support**: Switch between different image sets (e.g., "Default" vs "Family").
    - Configurable via Environment Variables:
        - `UNIVERSE_ALLOW_SWITCHING=true`: Enables the universe selector dropdown in the AppBar.
        - `UNIVERSE_DEFAULT=universe-name`: Sets the default universe on startup.
- **Dynamic Asset Loading**: Automatically discovers new images added to `assets/images/universes/`.
- **Custom Image Upload**: Add your own photos from the main menu!

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

<br/>

---

<div align="center">

Made with **Antigravity** by **[Riccardo Carlesso](https://github.com/palladius)**

[![Antigravity](https://img.shields.io/badge/Made%20with-Antigravity-blueviolet?style=for-the-badge&logo=google-cloud)](https://github.com/palladius)

</div>
