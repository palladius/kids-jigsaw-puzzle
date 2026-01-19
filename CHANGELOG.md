# CHANGELOG

Note: version can be ascertained bia `just version`.

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
