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
}
