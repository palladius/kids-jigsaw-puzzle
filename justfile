# List available commands
default:
    @just --list

# Run the app on Linux
run-linux:
    flutter run -d linux

# Build the app for Linux
build-linux:
    flutter build linux

build-magic:
    uname | grep Darwin && just build-macos 
    uname | grep Linux && just build-linux
    uname | grep MINGW64 && just build-windows

# Build the app for macOS
build-macos:
    @xcode-select -p | grep -q "Xcode.app" || (echo "❌ ERROR: Full Xcode is NOT installed or NOT active." && echo "Current path: $(xcode-select -p)" && echo "Please install Xcode from the App Store and run: 'just setup-mac-xcode'" && exit 1)
    flutter build macos

# Build the app for Windows
build-windows:
    flutter build windows

# Build the app for Android (APK)
build-android:
    flutter build apk

# Build the app for Web
build-web:
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
    @echo "🏆 Hall of Fame:"
    @cat ~/.local/share/com.palladius.kids_jigsaw_puzzle/shared_preferences.json | \
        jq -r '."flutter.high_scores" | fromjson | sort_by(.score) | reverse | ["SCORE","NAME","GRID","TIME"], ["-----","----","----","----"], (.[] | [.score, .name, "\(.gridSize)x\(.gridSize)", "\(.seconds)s"]) | join("|")' | \
        column -t -s "|" | sed 's/^/  /'

install-mac:
    brew install flutter cocoapods

setup-mac: install-mac
    flutter doctor

setup-mac-xcode:
    sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
    sudo xcodebuild -runFirstLaunch
