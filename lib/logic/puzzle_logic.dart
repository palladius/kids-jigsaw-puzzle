class PuzzleTile {
  final int correctIndex;
  int currentIndex;

  PuzzleTile({required this.correctIndex, required this.currentIndex});
}

class PuzzleGame {
  final int gridSize;
  late List<PuzzleTile> tiles;

  PuzzleGame({required this.gridSize}) {
    _initializeTiles();
  }

  void _initializeTiles() {
    tiles = List.generate(
      gridSize * gridSize,
      (index) => PuzzleTile(correctIndex: index, currentIndex: index),
    );
  }

  void shuffle() {
    tiles.shuffle();
    // Update currentIndex for all tiles after shuffle
    for (int i = 0; i < tiles.length; i++) {
      tiles[i].currentIndex = i;
    }
  }

  void swap(int index1, int index2) {
    final temp = tiles[index1];
    tiles[index1] = tiles[index2];
    tiles[index2] = temp;
    
    // Update currentIndex
    tiles[index1].currentIndex = index1;
    tiles[index2].currentIndex = index2;
  }

  bool areTilesConnected(int index1, int index2) {
    if (index1 < 0 || index1 >= tiles.length || index2 < 0 || index2 >= tiles.length) {
      return false;
    }
    
    final tile1 = tiles[index1];
    final tile2 = tiles[index2];
    
    // Check if they are physically adjacent in the current grid
    final row1 = index1 ~/ gridSize;
    final col1 = index1 % gridSize;
    final row2 = index2 ~/ gridSize;
    final col2 = index2 % gridSize;
    
    if ((row1 - row2).abs() + (col1 - col2).abs() != 1) {
      return false;
    }

    // Check if they SHOULD be adjacent (based on correctIndex)
    // The difference in correctIndex should match the difference in currentIndex
    // But we need to be careful about wrapping.
    // correctIndex is also a grid index.
    final correctRow1 = tile1.correctIndex ~/ gridSize;
    final correctCol1 = tile1.correctIndex % gridSize;
    final correctRow2 = tile2.correctIndex ~/ gridSize;
    final correctCol2 = tile2.correctIndex % gridSize;

    // Relative position in current grid must match relative position in correct grid
    return (row1 - row2) == (correctRow1 - correctRow2) &&
           (col1 - col2) == (correctCol1 - correctCol2);
  }

  Set<int> getIsland(int index) {
    final island = <int>{};
    final queue = <int>[index];
    island.add(index);

    while (queue.isNotEmpty) {
      final current = queue.removeAt(0);
      final row = current ~/ gridSize;
      final col = current % gridSize;

      // Check all 4 neighbors
      final neighbors = [
        if (row > 0) current - gridSize,
        if (row < gridSize - 1) current + gridSize,
        if (col > 0) current - 1,
        if (col < gridSize - 1) current + 1,
      ];

      for (final neighbor in neighbors) {
        if (!island.contains(neighbor) && areTilesConnected(current, neighbor)) {
          island.add(neighbor);
          queue.add(neighbor);
        }
      }
    }
    return island;
  }

  bool canMoveIsland(int sourceIndex, int targetIndex) {
    final island = getIsland(sourceIndex);
    final offset = targetIndex - sourceIndex;
    
    for (final idx in island) {
      final target = idx + offset;
      
      if (target < 0 || target >= tiles.length) return false;
      
      final sourceRow = idx ~/ gridSize;
      final sourceCol = idx % gridSize;
      final targetRow = target ~/ gridSize;
      final targetCol = target % gridSize;
      
      final mainSourceRow = sourceIndex ~/ gridSize;
      final mainSourceCol = sourceIndex % gridSize;
      final mainTargetRow = targetIndex ~/ gridSize;
      final mainTargetCol = targetIndex % gridSize;
      
      final expectedRowDiff = mainTargetRow - mainSourceRow;
      final expectedColDiff = mainTargetCol - mainSourceCol;
      
      if (targetRow - sourceRow != expectedRowDiff || 
          targetCol - sourceCol != expectedColDiff) {
        return false;
      }
    }
    return true;
  }

  // Returns true if the move was successful
  bool moveIsland(int sourceIndex, int targetIndex) {
    if (!canMoveIsland(sourceIndex, targetIndex)) return false;

    final island = getIsland(sourceIndex);
    final offset = targetIndex - sourceIndex;
    
    final sourceSet = island;
    final targetSet = island.map((i) => i + offset).toSet();
    
    // Identify tiles that are being displaced but are NOT part of the moving island
    final displacedIndices = targetSet.difference(sourceSet).toList()..sort();
    
    // Identify indices that are being vacated and are NOT receiving a tile from the island
    final vacatedIndices = sourceSet.difference(targetSet).toList()..sort();
    
    // Sanity check: The number of displaced tiles must match the number of vacated spots
    if (displacedIndices.length != vacatedIndices.length) {
      // This should theoretically not happen if canMoveIsland checks are correct
      return false;
    }

    final newTiles = List<PuzzleTile>.from(tiles);
    
    // 1. Move island tiles to their target positions
    for (final idx in sourceSet) {
      final target = idx + offset;
      newTiles[target] = tiles[idx];
      newTiles[target].currentIndex = target;
    }
    
    // 2. Move displaced tiles to vacated positions
    for (int i = 0; i < displacedIndices.length; i++) {
      final source = displacedIndices[i];
      final target = vacatedIndices[i];
      newTiles[target] = tiles[source];
      newTiles[target].currentIndex = target;
    }
    
    tiles = newTiles;
    return true;
  }

  bool isSolved() {
    for (int i = 0; i < tiles.length; i++) {
      if (tiles[i].currentIndex != tiles[i].correctIndex) {
        return false;
      }
    }
    return true;
  }
}
