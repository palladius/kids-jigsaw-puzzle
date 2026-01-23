# List available commands
default:
    @just --list

# Run the app on Linux
run-linux: update-version
    flutter run -d linux

run-mac:
    flutter run -d macos

run-ios:
    flutter run -d ios

# Update the image list dynamically
update-images:
# Update the image list dynamically
update-images:
    dart scripts/update_images.dart

# Update version from pubspec to constants.dart
update-version:
    dart scripts/update_version.dart

# Build the app for Linux
build-linux: update-images update-version
    flutter build linux

build-magic: update-images
    uname | grep Darwin && just build-macos 
    uname | grep Linux && just build-linux
    uname | grep MINGW64 && just build-windows

# Build the app for macOS
build-macos: update-images update-version
    @xcode-select -p | grep -q "Xcode.app" || (echo "❌ ERROR: Full Xcode is NOT installed or NOT active." && echo "Current path: $(xcode-select -p)" && echo "Please install Xcode from the App Store and run: 'just setup-mac-xcode'" && exit 1)
    flutter build macos

# Build the app for Windows
build-windows: update-images update-version
    flutter build windows

# Build the app for iOS
build-ios: update-images update-version
    flutter build ios --no-codesign

# Open iOS Simulator
open-simulator:
    open -a Simulator

# Build the app for Android (APK)
build-android: update-images update-version
    flutter build apk

# Build the app for Web
build-web: update-images update-version
    flutter build web --base-href "/kids-jigsaw-puzzle/"

build-all: build-linux build-macos build-windows build-android
    @echo "Building all arhitecture available: Linux, macOS, Windows, Android"

# Run tests
test:
    flutter test

# Clean build artifacts
clean:
    flutter clean

# Show the current version
version:
    @grep '^version: ' pubspec.yaml | cut -d ' ' -f 2

# Run with logging to a file
log-run:
    flutter run -d linux > app.log 2>&1

# Run in debug mode (2x2 grid enabled)
debug-run-linux:
    flutter run -d linux --dart-define=GAME_DEBUG=true

# Print the Hall of Fame (Linux only)
print-hall-of-fame:
    @echo "🏆 Hall of Fame (works on Linux but not on Mac):"
    @cat ~/.local/share/com.palladius.kids_jigsaw_puzzle/shared_preferences.json | \
        jq -r '."flutter.high_scores" | fromjson | sort_by(.score) | reverse | ["SCORE","NAME","GRID","TIME"], ["-----","----","----","----"], (.[] | [.score, .name, "\(.gridSize)x\(.gridSize)", "\(.seconds)s"]) | join("|")' | \
        column -t -s "|" | sed 's/^/  /'

install-mac:
    brew install flutter cocoapods

setup-mac: install-mac
    flutter doctor

# setup-mac-xcode:
#     @ls -d /Applications/Xcode.app 2>/dev/null && sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer || (ls -d ~/Downloads/Xcode.app 2>/dev/null && sudo xcode-select --switch ~/Downloads/Xcode.app/Contents/Developer) || (echo "❌ Xcode not found in /Applications or ~/Downloads" && exit 1)
#     sudo xcodebuild -runFirstLaunch

count-images:
    ls assets/images | wc -l

# Install dependencies (generic)
install:
    @uname | grep Darwin && just install-mac || echo "Skipping Mac install"
    @uname | grep Linux && just install-linux || echo "Skipping Linux install"

# Install Linux dependencies
install-linux:
    sudo apt-get update
    sudo apt-get install -y clang cmake ninja-build pkg-config libgtk-3-dev
    which flutter || sudo snap install flutter --classic
    flutter doctor
