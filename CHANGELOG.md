# CHANGELOG

Note: version can be ascertained bia `just version`.

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
