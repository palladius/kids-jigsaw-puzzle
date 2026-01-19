# List available commands
default:
    @just --list

# Run the app on Linux
run-linux:
    flutter run -d linux

# Build the app for Linux
build-linux:
    flutter build linux

# Build the app for Android (APK)
build-android:
    flutter build apk

# Run tests
test:
    flutter test

# Clean build artifacts
clean:
    flutter clean

# Show the current version
version:
    @grep '^version: ' pubspec.yaml | cut -d ' ' -f 2