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
