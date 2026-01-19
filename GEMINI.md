# Project Instructions

## Context

This is an **incubator project** for a kid-friendly jigsaw puzzle game built with Flutter.

## 📚 Resources

- **Main README**: See `README.md` for complete game design and technical specs
- **Blueprint**: See `blueprint.yaml` for project metadata

## 💡 Game Concept

An interactive jigsaw puzzle where:
1. Kids upload their own images (family photos, superheroes, etc.)
2. Choose difficulty (4x4, 6x6, 8x8 grids)
3. Swap tiles by tapping/clicking
4. **Key mechanic**: Adjacent tiles that are correctly placed automatically merge into larger tiles
5. Borders disappear between merged tiles for seamless look
6. Win when all tiles are merged!

## 🎯 Primary Requirements

- **MUST work on Android** (this is non-negotiable)
- Touch-friendly UI for kids
- Custom image upload
- Multiple difficulty levels
- Tile merging mechanic

## 🛠️ Tech Stack

- **Framework**: Flutter (Dart)
- **Platforms**: Android (required), iOS/Web/Desktop (bonus)
- **Google Stack**: Firebase, Cloud Storage (optional but preferred)

## 📋 TODO

### Phase 1: MVP
- [x] Set up Flutter project
- [x] Design basic UI mockups
- [x] Implement image selection (gallery)
- [x] Implement 4x4 grid
- [x] Implement tile swapping
- [x] Implement merge detection logic
- [x] Implement border removal on merge
- [ ] Test on Android device

### Phase 2: Polish
- [ ] Add more difficulty levels (6x6, 8x8)
- [ ] Add camera support
- [ ] Add animations
- [ ] Add sound effects
- [ ] Add timer/score
- [ ] Add hint system

### Phase 3: Cloud Integration
- [ ] Firebase setup
- [ ] Cloud image storage
- [ ] Save/load progress
- [ ] Share puzzles

## 🎨 Design Notes

- Keep it **simple and colorful** for kids
- Large, tappable UI elements
- Satisfying feedback (animations, sounds)
- No complex menus
- Celebration on puzzle completion!

## 🧪 Testing

- Test with real kids (your target audience!)
- Test on various Android devices
- Test with different image types/sizes
- Performance testing with large grids

## 💡 AI Pair Programming

This project is designed to be built **with AI assistance** (vibecode):
- Use AI to generate Flutter boilerplate
- Ask AI for widget implementations
- Get help with merging algorithm
- Request UI/UX improvements
- Debug issues together

Perfect for iterative development with Gemini! 🤖

# You and me

* Let's use `gh` to read/write a GitHub issues. Let's use issues for BIG interactive changes.


## Feedback Loop

when you land some critical feature or bug fix, make sure to:
* bump version by 0.0.1
* update CHANGELOG.md
* `git commit` with gitmoji
* If unsure, ask user if this is ok.