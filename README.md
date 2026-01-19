# 🧩 Kids Jigsaw Puzzle Game

![Grid Logo](grid-image.png)

> **Goal**: Create an interactive jigsaw puzzle game for kids where they can use their own photos (family, heroes, etc.) and solve puzzles by swapping tiles. Adjacent correct tiles merge automatically!


## 🎯 Objectives

- [ ] Build a kid-friendly jigsaw puzzle game
- [ ] Support custom image uploads (family photos, superheroes, etc.)
- [ ] Multiple difficulty levels (4x4, 6x6, 8x8, etc.)
- [ ] Works perfectly on Android (PRIMARY REQUIREMENT)
- [ ] Tile swapping via touch (mobile) or mouse (desktop)
- [ ] Auto-merge adjacent tiles when correctly placed
- [ ] Seamless border removal on merged tiles
- [ ] Built with Flutter for cross-platform support
- [ ] Bonus: Google Cloud/Firebase integration

## 🎮 Game Mechanics

### Core Gameplay

1. **Image Selection**: User picks an image from:
   - Camera roll
   - Family photos
   - Pre-loaded sample images (heroes, animals, etc.)

2. **Difficulty Selection**: Choose grid size:
   - 🟢 Easy: 4x4 (16 tiles)
   - 🟡 Medium: 6x6 (36 tiles)
   - 🔴 Hard: 8x8 (64 tiles)
   - ⚫ Expert: 10x10 (100 tiles) - optional

3. **Puzzle Solving**:
   - Tap/click two tiles to swap their positions
   - When two tiles are **correctly adjacent** (relatively), they automatically merge
   - Merged tiles become one larger tile (L-shaped, T-shaped, etc.)
   - Internal borders disappear on merge for seamless look
   - Continue until all tiles are merged into complete image

4. **Win Condition**: All tiles merged = Puzzle solved! 🎉

### Merging Logic

**Key Innovation**: Tiles merge when they are "relatively adjacent" (correctly placed next to each other):

```
Example:
[A][B]  <- If A and B are swapped to correct positions next to each other
        -> They merge into [AB] (one tile, no border between)
        
[AB]    <- This merged tile can now merge with C
[C]     -> Becomes [ABC] (L-shaped tile)
```

**Rules**:
- Only correctly positioned adjacent tiles merge
- Once merged, tiles cannot be separated
- Borders between merged tiles disappear
- Merged tiles move as one unit

## 🎨 UI/UX Design

### Kid-Friendly Features
- **Large, colorful buttons**
- **Simple tap/click interface**
- **Visual feedback** (animations, sounds)
- **No complex menus** - keep it simple!
- **Bright, engaging colors**
- **Celebration animations** on puzzle completion

### Screens

1. **Home Screen**
   - "New Puzzle" button
   - "Continue" button (if saved puzzles exist)
   - Settings icon

2. **Image Selection Screen**
   - Gallery view of available images
   - "Upload Photo" button
   - "Take Photo" button (camera)
   - Sample images grid

3. **Difficulty Selection Screen**
   - Visual representation of grid sizes
   - Easy/Medium/Hard/Expert buttons

4. **Game Screen**
   - Puzzle grid
   - Preview of complete image (optional, can be hidden)
   - Timer (optional)
   - Hint button (optional)
   - Restart button
   - Back button

5. **Victory Screen**
   - Completed image
   - Celebration animation
   - Time taken
   - "Play Again" button
   - "Share" button (optional)

## 🛠️ Technical Implementation

### Tech Stack

**Framework**: Flutter  
**Language**: Dart  
**Platforms**: 
- ✅ Android (PRIMARY - REQUIRED)
- ✅ iOS (bonus)
- ✅ Web (bonus)
- ✅ Desktop (bonus)

**Packages Needed**:
- `image_picker` - For photo selection
- `image` - For image manipulation/cropping
- `provider` or `riverpod` - State management
- `shared_preferences` - Save progress
- `firebase_core` + `firebase_storage` - Optional cloud storage
- `flutter_animate` - Animations
- `audioplayers` - Sound effects (optional)

### Core Components

1. **Image Handler**
   - Load image from gallery/camera
   - Crop/resize to square
   - Split into NxN tiles
   - Store tile positions

2. **Tile Manager**
   - Track tile positions (current vs. correct)
   - Handle tile swapping
   - Detect adjacent tiles
   - Merge logic
   - Border rendering

3. **Game State Manager**
   - Current puzzle state
   - Merged tile groups
   - Move counter
   - Timer
   - Win detection

4. **UI Components**
   - Tile widget (with borders, images)
   - Grid layout
   - Selection indicators
   - Animations

### Data Structures

```dart
class Tile {
  int id;
  int currentRow, currentCol;
  int correctRow, correctCol;
  Image imagePart;
  List<int> mergedWith; // IDs of tiles merged with this one
  bool isCorrectlyPlaced;
}

class PuzzleState {
  List<Tile> tiles;
  int gridSize; // 4, 6, 8, 10
  Image originalImage;
  DateTime startTime;
  int moveCount;
  bool isComplete;
}
```

### Merging Algorithm

```dart
// Pseudo-code
void checkAndMergeTiles(Tile tile1, Tile tile2) {
  if (areAdjacent(tile1, tile2) && areCorrectlyPlaced(tile1, tile2)) {
    mergeTiles(tile1, tile2);
    removeBorderBetween(tile1, tile2);
    checkWinCondition();
  }
}

bool areAdjacent(Tile t1, Tile t2) {
  // Check if tiles are next to each other (horizontally or vertically)
  return (abs(t1.currentRow - t2.currentRow) == 1 && t1.currentCol == t2.currentCol) ||
         (abs(t1.currentCol - t2.currentCol) == 1 && t1.currentRow == t2.currentRow);
}

bool areCorrectlyPlaced(Tile t1, Tile t2) {
  // Check if both tiles are in their correct positions relative to each other
  return t1.isCorrectlyPlaced && t2.isCorrectlyPlaced;
}
```

## 📱 Platform-Specific Considerations

### Android (PRIMARY)
- ✅ Touch-optimized UI
- ✅ Responsive grid layout
- ✅ Gesture detection (tap, drag)
- ✅ Permissions for camera/gallery access
- ✅ Adaptive icon
- ✅ Material Design 3

### iOS (Bonus)
- Human Interface Guidelines
- iOS-specific permissions

### Web (Bonus)
- Responsive design
- Mouse + touch support
- PWA capabilities

## 🎯 MVP Features (Phase 1)

- [ ] Basic Flutter app setup
- [ ] Image selection from gallery
- [ ] 4x4 grid only (easy mode)
- [ ] Tile swapping (tap two tiles)
- [ ] Basic merge detection
- [ ] Border removal on merge
- [ ] Win detection
- [ ] Simple victory screen
- [ ] Works on Android

## 🚀 Future Enhancements (Phase 2+)

- [ ] Multiple difficulty levels (6x6, 8x8, 10x10)
- [ ] Camera integration (take photo)
- [ ] Pre-loaded sample images
- [ ] Timer and move counter
- [ ] Hint system
- [ ] Sound effects and music
- [ ] Animations (tile swap, merge, victory)
- [ ] Save/load progress
- [ ] Multiple puzzles in progress
- [ ] Leaderboard (fastest times)
- [ ] Share completed puzzles
- [ ] Firebase integration
- [ ] Cloud storage for images
- [ ] Multiplayer mode (?)

## 🎨 Design Inspiration

- Bright, colorful palette (kid-friendly)
- Large, tappable tiles
- Smooth animations
- Satisfying merge effects
- Celebration confetti on win
- Cute sound effects

## 📚 Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Flutter Image Picker](https://pub.dev/packages/image_picker)
- [Flutter Provider](https://pub.dev/packages/provider)
- [Material Design 3](https://m3.material.io/)
- [Firebase Flutter Setup](https://firebase.google.com/docs/flutter/setup)

## 🗒️ Development Notes

### Questions to Answer
- Should merged tiles be draggable as a group?
- How to handle very large merged tile groups?
- Should there be a "shuffle" button?
- Preview image always visible or hide-able?
- Sound on/off toggle?
- Difficulty auto-detection based on age?

### Technical Challenges
- Efficient image cropping/splitting
- Smooth tile animations
- Border rendering for irregular merged shapes
- Touch detection for overlapping merged tiles
- Performance with large grids (10x10)

### Testing Plan
- [ ] Test on various Android devices (phones, tablets)
- [ ] Test with different image sizes/ratios
- [ ] Test all difficulty levels
- [ ] Kid testing (real users!)
- [ ] Performance testing (large grids)

---

**Created**: 2026-01-15  
**Last Updated**: 2026-01-15  
**Owner**: Riccardo (ricc@google.com)  
**Target Audience**: Kids (ages 4-12)  
**Primary Platform**: Android 📱

![Example image of Ricc kids](image.png)
