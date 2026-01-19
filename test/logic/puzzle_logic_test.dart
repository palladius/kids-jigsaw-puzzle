import 'package:flutter_test/flutter_test.dart';
import 'package:kids_jigsaw_puzzle/logic/puzzle_logic.dart';

void main() {
  group('PuzzleGame Logic', () {
    late PuzzleGame game;

    setUp(() {
      game = PuzzleGame(gridSize: 4); // 4x4 grid
      // Reset to solved state for predictable testing
      for (int i = 0; i < game.tiles.length; i++) {
        game.tiles[i] = PuzzleTile(correctIndex: i, currentIndex: i);
      }
    });

    test('Initial state is solved', () {
      expect(game.isSolved(), isTrue);
    });

    test('Swap two tiles', () {
      game.swap(0, 1);
      expect(game.tiles[0].correctIndex, 1);
      expect(game.tiles[1].correctIndex, 0);
      expect(game.isSolved(), isFalse);
    });

    test('Island detection - single tile (solved state)', () {
      final island = game.getIsland(0);
      // In a fully solved puzzle, all tiles are connected.
      expect(island.length, 16); 
    });

    test('Island detection - two connected tiles', () {
      // 0 and 1 are adjacent. They are already "connected" in solved state.
      // Let's verify they are detected as an island if we consider them connected.
      // Wait, getIsland checks `areTilesConnected`.
      // In a solved state, ALL tiles are connected to their neighbors?
      // Let's check `areTilesConnected` logic.
      // It checks physical adjacency AND correct relative position.
      // So in a solved puzzle, EVERYTHING is one giant island?
      
      final island = game.getIsland(0);
      // In a fully solved puzzle, 0 is connected to 1, 4. 1 is connected to 0, 2, 5...
      // So getIsland(0) should return ALL indices.
      expect(island.length, 16); 
    });

    test('Island detection - broken connection', () {
      // Swap 0 and 1. Now 0 is at 1, 1 is at 0.
      // Tile at 0 (was 1) has correctIndex 1.
      // Tile at 1 (was 0) has correctIndex 0.
      // Tile at 0 (correct 1) vs Tile at 4 (correct 4).
      // Row diff: 4-0 = 1. Col diff: 0-0 = 0.
      // Correct Row diff: (4/4)-(1/4) = 1-0 = 1.
      // Correct Col diff: (4%4)-(1%4) = 0-1 = -1.
      // 0 != -1. So Tile at 0 is NOT connected to Tile at 4.
      
      game.swap(0, 1);
      
      // Now let's check island of tile at 0 (which is the tile with correctIndex 1).
      // It should NOT be connected to 4.
      // Is it connected to 1 (which is tile with correctIndex 0)?
      // Pos 0 vs Pos 1.
      // Row diff: 0. Col diff: -1.
      // Correct: 1 vs 0.
      // Correct Row diff: 0. Correct Col diff: 1.
      // -1 != 1. Not connected.
      
      final island = game.getIsland(0);
      expect(island.length, 1); // Should be isolated
    });

    test('Move Island - No Duplication (2x2)', () {
      // Use 2x2 grid for simplicity
      game = PuzzleGame(gridSize: 2);
      // Initial: 0 1
      //          2 3
      
      // We want to create an island of {0, 1} at positions {2, 3}.
      // And have {2, 3} at positions {0, 1}.
      // So effectively we swap row 0 and row 1.
      // Current:
      // 0: T0, 1: T1
      // 2: T2, 3: T3
      
      // Swap 0 with 2, and 1 with 3.
      game.swap(0, 2);
      game.swap(1, 3);
      
      // State:
      // 0: T2, 1: T3
      // 2: T0, 3: T1
      
      // Check island at 2. Should be {2, 3}.
      final island = game.getIsland(2);
      expect(island.contains(2), isTrue);
      expect(island.contains(3), isTrue);
      expect(island.length, 2);
      
      // Move island {2, 3} to {0, 1}. Offset -2.
      // Target positions: 0, 1.
      // Displaced tiles: T2 (at 0), T3 (at 1).
      // Vacated positions: 2, 3.
      
      final success = game.moveIsland(2, 0);
      expect(success, isTrue);
      
      // Expected result:
      // 0: T0 (Moved from 2)
      // 1: T1 (Moved from 3)
      // 2: T2 (Displaced from 0 to 2)
      // 3: T3 (Displaced from 1 to 3)
      
      expect(game.tiles[0].correctIndex, 0);
      expect(game.tiles[1].correctIndex, 1);
      expect(game.tiles[2].correctIndex, 2);
      expect(game.tiles[3].correctIndex, 3);
      
      // Check for duplicates
      final correctIndices = game.tiles.map((t) => t.correctIndex).toList();
      final uniqueIndices = correctIndices.toSet();
      expect(uniqueIndices.length, game.tiles.length, reason: 'Duplicate tiles found!');
    });
  });
}
