# CHANGELOG

Note: version can be ascertained bia `just version`.

## 1.1.9+22

- 🪐 **Universe Support**: Introduced concept of "Universes" (e.g., Default, Family) to grouping images.
- 🛠️ **Environment Variables**: Use `UNIVERSE_ALLOW_SWITCHING=true` to show the selector, and `UNIVERSE_DEFAULT` to set the starting universe.
- 🏗️ **Robust Asset Loading**: Switched to modern `AssetManifest` API to fixing image discovery on newer Flutter versions.
- 🧹 **Cleanup**: Removed static image lists and update scripts; everything is now dynamic!
- 🏷️ **Version Sync**: Bumped version to v1.1.9+22.

## 1.1.8+21

- 🛫 **Extreme Difficulty**: Added "Airport Wait" (10x10) and "Netflix is Down" (12x12) for those extra long sessions.
- 🏷️ **Version Sync**: Bumped version to v1.1.8+21.

## 1.1.7+20

- 📱 **Responsive Layout**: Added a side-by-side layout for larger screens (desktop/tablet) to fit all options in a single frame.
- 🍋 **New Difficulty Levels**: Added "Lemon Squeezy" (5x5) and "Whiz Kid" (7x7).
- 🎉 **Fun Names**: Renamed difficulty levels to be more kid-friendly (Easy Peasy, Smarty Pants, Genius Mode).
- 🏷️ **Version Sync**: Bumped version to v1.1.7+20.

## 1.1.6+19

- 🖼️ **New Image Selector**: Replaced the horizontal list with a matrix/grid view for better navigation.
- 🔍 **Search Functionality**: Added a search bar to easily find images by name.
- 🎲 **Random vs Choose**: Clear distinction between picking a random image and choosing a specific one.
- 🏷️ **Version Sync**: Bumped version to v1.1.6+19.

## 1.1.5+18

- ☁️ **Cloud Sync Fix**: Updated GitHub Actions to run the image sync script during deployment. Now, the web version will always be in sync with the repository assets, even for images added directly in the cloud!
- 🏷️ **Version Sync**: Bumped version to v1.1.5+18.

## 1.1.5+17

## 1.1.5+16

- 🍎 **Mac Build Stabilized**: Fixed `pubspec.yaml` dependency conflicts (`cupertino_icons` and `shared_preferences`).
- 📦 **Dependencies**: Updated `intl`, `confetti`, and `shared_preferences` to latest compatible versions.
- 🛠️ **Justfile**: Added `install-mac` and `setup-mac` recipes for easier environment setup.
- 📖 **Docs Refactor**: Slimmed down `README.md` and moved detailed specifications to `SPECS.md`.
- 🏷️ **Version Sync**: Bumped version to v1.1.5+16.

## 1.1.4+15

- 🖱️ **Desktop Scrolling**: Enabled mouse-drag scrolling for the image selector. You can now click and drag to scroll through all 11 images on Linux/Desktop.
- 🏷️ **Version Sync**: Bumped version to v1.1.4+15.

## 1.1.3+14

- 🖼️ **Image Selector**: Added a horizontal image selector to the Main Menu.
- 🎲 **Random Default**: Defaults to "Random" but allows choosing a specific image.
- 🔍 **Zoomed Thumbnails**: Thumbnails show a zoomed-in portion of the image to keep the puzzle challenging.
- 🏷️ **Version Sync**: Bumped version to v1.1.3+14.

## 1.1.2+13

- 🛠️ **Justfile Fix**: Restored accidentally deleted commands and added `print-hall-of-fame`.
- 🏷️ **Version Sync**: Bumped version to v1.1.2+13.

## 1.1.1+12

- 🏆 **Unique High Scores**: The Hall of Fame now only keeps the **best score per player** (case-insensitive). No more clogging the leaderboard with multiple entries from the same person!
- 🏷️ **Version Sync**: Bumped version to v1.1.1+12.

## 1.1.0+11

- ⌨️ **Name Autocomplete**: The win dialog now suggests names already in the Hall of Fame (case-insensitive) to prevent typos.
- 🏷️ **Version Sync**: Bumped version to v1.1.0+11.

## 1.0.9+10

- 🏆 **Hall of Fame**: Added a persistent leaderboard! Players can now enter their names after winning.
- 🧮 **Exponential Scoring**: Implemented a scoring system that rewards larger grids and faster times (Complexity is $O(N^4)$).
- 🖼️ **Better View**: Moved the "Bravo" win dialog to the left side of the screen so you can admire your completed puzzle.
- 🏷️ **Version Sync**: Bumped version to v1.0.9+10.

## 1.0.8+9

- 📂 **Asset Reorganization**: Moved all images from `sample-images/` to the standard Flutter directory `assets/images/`.
- 🏷️ **Version Sync**: Bumped version to v1.0.8+9.

## 1.0.7+8

- 🎉 **Win Celebration**: Added fireworks (confetti) when you solve the puzzle!
- 🐞 **Debug Mode**: Added support for `GAME_DEBUG` environment variable. If true, a super easy 2x2 grid option appears in the menu.
- 🎲 **Image Randomization**: The game now picks a random image from the assets each time you start a new game.
- 🏷️ **Version Sync**: Bumped version to v1.0.7+8.

## 1.0.6+7

- 🛡️ **Aggressive State Cleanup**: Added `_draggedTileIds = {}` to `onAccept` and `onDragCompleted` to ensure the grey boxes (white bug) are cleared immediately upon a successful move, even if `onDragEnd` is delayed or missed.
- 🏷️ **Version Sync**: Bumped version to v1.0.6+7.

## 1.0.5+6

- 🛡️ **Deep Fix**: Resolved the "white tiles" bug by ensuring `Draggable` widgets are never removed from the tree during a drag. This ensures `onDragEnd` is always called to clear the drag state.
- 📝 **Logging**: Added `debugPrint` statements for drag and move events.
- 🛠️ **Justfile**: Added `just log-run` to redirect app output to `app.log`.

## 1.0.4+5

- 🛡️ **Robustness Fix**: Improved tile tracking during dragging by using `correctIndex` (unique ID) instead of grid positions. This fixes the "white tiles" (stuck grey boxes) issue.
- 🧪 **Sanity Checks**: Added a runtime check to `moveIsland` to prevent any move that would result in duplicate tiles.
- 🔑 **Stable Keys**: Re-implemented `ValueKey` on individual tiles for better Flutter reconciliation.

## 1.0.3+4

- 🔄 **Full Repaint**: Forced a full grid repaint on every move using a global key strategy to ensure all borders (including neighbors) are updated correctly.
- 🏷️ **Version Update**: Bumped version to v1.0.3+4.

## 1.0.2+3

- 🛡️ **Critical Fix**: Implemented immutable tile state to prevent duplication and reference sharing bugs.
- 🔑 **Flutter Keys**: Added `ValueKey` to all tiles to ensure correct widget tracking and rebuilds.
- 🏷️ **Version Footer**: Added version info at the bottom right of the game screen.
- 📏 **UI Polish**: Added padding to the puzzle board.

## 1.0.1+2
