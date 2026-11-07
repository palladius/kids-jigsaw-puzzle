# CHANGELOG

Note: version can be ascertained bia `just version`.

## 1.1.17+30

- 🐧 **PuffinLogin Integration (`puffin-login` v1.0)**:
  - Integrated the 6 Pixar RPG family profiles (**Papino Riccardo** 👑 `#FACC15`, **Mamma Kate** 💜 `#A855F7`, **Alessandro (Ale)** 🐉 `#EF4444`, **Sebastian (Seby)** 🏎️ `#3B82F6`, **Nonna Lucilla** 🌸 `#EC4899`, and **Guest / Ospite** 🐧 `#9CA3AF`) with zero-plaintext salted SHA-256 verification (`SHA-256("puffin-salt-2026:<userId>:<secret>")`).
  - Added `<puffin-login app-id="kids-jigsaw-puzzle" require-login="true">` and `<puffin-leaderboard filter-game="kids-jigsaw-puzzle">` in `web/index.html` (`web/src/puffin-login.js`) + native Flutter `PuffinLogin` (`lib/logic/puffin_login.dart`) for Web, Linux, macOS, and Android.
  - Shared-origin `localStorage['puffin_auth_v2']` & `localStorage['puffin_scores_v2']` sync across all `https://palladius.github.io/*` games, plus live Cloud Firestore sync on GCP project `ror-goldie` (`database: puffin-login` via Cloud Run `/v1/scores`).
  - Automatic score submission for the logged-in hero in `WinDialog` (no more typing your name!) and minimalist Hall of Fame in `LeaderboardScreen` & `WinDialog`.
  - Added the 6-Hero RPG lineup (`assets/images/puffin-family-6.png`) as a playable jigsaw puzzle image!
- 🏷️ **Version Sync**: Bumped version to v1.1.17+30.

## 1.1.16+29

- 🏗️ **CI Fix**: Removed obsolete `update_images.dart` script that was breaking the build. The app now uses dynamic asset loading, so the manual list update is no longer needed. Fixed broken GHA (Issue #8).
- 🏷️ **Version Sync**: Bumped version to v1.1.16+29.

## 1.1.15+28

- 🛑 **Exit Confirmation**: The Back button (and new shortcuts 'B'/'Backspace') now asks for confirmation before quitting. No more accidental exits!
- 🎨 **Dialog Polish**: "Are you sure?" dialogs now feature colorful buttons, with "Safe" options (Stay/No) focused by default.
- 🏷️ **Version Sync**: Bumped version to v1.1.15+28.

## 1.1.14+27

- ⬅️ **Reload Relocated**: Moved the Reload button to the left (next to Back button) to prevent accidental clicks near Tips/Hints.
- 🐛 **Fix**: Restored missing functionality and fixed compilation errors.
- 🏷️ **Version Sync**: Bumped version to v1.1.14+27.

## 1.1.13+26

- 👮 **Score Penalty**: Using Tips now deducts 1000 points from the final score! No free lunch.
- 🎨 **Title Polish**: Added version number to the Main Menu title (Bold Name + Normal Version).
- 🎨 **Help Polish**: Improved Help dialog with cleaner toggling (H) and visual keys.
- 🏷️ **Version Sync**: Bumped version to v1.1.13+26.

## 1.1.12+25

- 🛡️ **Restart Confirmation**: Added an "Are you sure?" dialog to the Reload button to prevent accidental restarts.
- 🏷️ **Version Sync**: Bumped version to v1.1.12+25.

## 1.1.11+24

- 🐛 **Dynamic Image Loading**: Switched from a hardcoded image list to dynamic loading using `AssetManifest`. This fixes the "Missing Asset" bug forever.
- 🏷️ **Version Sync**: Bumped version to v1.1.11+24.

## 1.1.10+23

- ⌨️ **Keyboard Shortcuts**: Added keyboard controls for power users!
    - **Spacebar**: Hold to activate X-ray vision.
    - **T**: Trigger a swap suggestion (Tip).
    - **H**: Show the Help dialog explaining shortcuts.
- 💡 **Smart Tips**: Added a "Tip" button (and 'T' key) that highlights two tiles to swap to make progress.
- ❓ **Help Dialog**: Added a legend for the new controls.
- 🏷️ **Version Sync**: Bumped version to v1.1.10+23.

## 1.1.9+22

- 👁️ **X-ray Vision**: Added an X-ray button to toggle visual hints! Correctly placed tiles/islands now glow green, while incorrect ones fade out.
- 🏝️ **Island Logic Confirmed**: Verified that the Adjacency Islands mechanic (Issue #1) is fully functional.
- 🐧 **Linux Setup**: Added `just install` and `just install-linux` for easier graphical setup on Linux.
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
