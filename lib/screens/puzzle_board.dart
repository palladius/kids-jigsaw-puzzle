import 'package:flutter/material.dart';

import 'package:kids_jigsaw_puzzle/logic/puzzle_logic.dart';

class PuzzleBoard extends StatefulWidget {
  final int gridSize;

  const PuzzleBoard({super.key, required this.gridSize});

  @override
  State<PuzzleBoard> createState() => _PuzzleBoardState();
}

class _PuzzleBoardState extends State<PuzzleBoard> {
  late PuzzleGame _game;
  final Stopwatch _stopwatch = Stopwatch();
  Set<int> _draggedTileIds = {};
  int _moveCount = 0;

  @override
  void initState() {
    super.initState();
    _game = PuzzleGame(gridSize: widget.gridSize);
    _game.shuffle();
    _stopwatch.start();
  }

  void _checkWin() {
    if (_game.isSolved()) {
      _stopwatch.stop();
      _showWinDialog();
    }
  }

  void _showWinDialog() {
    final duration = _stopwatch.elapsed;
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Bravo!'),
        content: Text('You won!\nIt took you $minutes min $seconds sec.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Go back to menu
            },
            child: const Text('Back to Menu'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              setState(() {
                _game.shuffle();
                _moveCount++;
                _stopwatch.reset();
                _stopwatch.start();
              });
            },
            child: const Text('Play Again'),
          ),
        ],
      ),
    );
  }

  Widget _buildTileContent(int index, double size, {bool isFeedback = false}) {
    final tile = _game.tiles[index];
    final fullImageSize = size * widget.gridSize;
    final int correctRow = tile.correctIndex ~/ widget.gridSize;
    final int correctCol = tile.correctIndex % widget.gridSize;

    // Check connections for borders
    final row = index ~/ widget.gridSize;
    final col = index % widget.gridSize;

    bool isConnected(int neighborIndex) {
      return _game.areTilesConnected(index, neighborIndex);
    }

    final topConnected = row > 0 && isConnected(index - widget.gridSize);
    final bottomConnected = row < widget.gridSize - 1 && isConnected(index + widget.gridSize);
    final leftConnected = col > 0 && isConnected(index - 1);
    final rightConnected = col < widget.gridSize - 1 && isConnected(index + 1);

    final borderSide = isFeedback 
      ? const BorderSide(color: Colors.yellow, width: 3.0)
      : BorderSide(
          color: Colors.white.withOpacity(0.8),
          width: 1.0,
        );
    
    final transparentSide = BorderSide(
      color: Colors.transparent,
      width: 0.0,
    );

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        border: Border(
          top: topConnected ? transparentSide : borderSide,
          bottom: bottomConnected ? transparentSide : borderSide,
          left: leftConnected ? transparentSide : borderSide,
          right: rightConnected ? transparentSide : borderSide,
        ),
      ),
      child: ClipRect(
        child: OverflowBox(
          maxWidth: fullImageSize,
          maxHeight: fullImageSize,
          minWidth: fullImageSize,
          minHeight: fullImageSize,
          alignment: Alignment(
            (correctCol / (widget.gridSize - 1)) * 2 - 1,
            (correctRow / (widget.gridSize - 1)) * 2 - 1,
          ),
          child: Image.asset(
            'sample-images/ale-seby-ski.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Puzzle Board (${widget.gridSize}x${widget.gridSize})'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _game.shuffle();
                _moveCount++;
                _stopwatch.reset();
                _stopwatch.start();
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.gridSize * widget.gridSize,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: widget.gridSize,
                    ),
                    itemBuilder: (context, index) {
                      final tile = _game.tiles[index];
                      
                      if (_draggedTileIds.contains(tile.correctIndex)) {
                        return Container(
                          key: ValueKey('placeholder-${tile.correctIndex}'),
                          color: Colors.grey.withOpacity(0.2),
                        );
                      }

                      return LayoutBuilder(
                        key: ValueKey('tile-${tile.correctIndex}'),
                        builder: (context, constraints) {
                          final size = constraints.maxWidth;

                          return DragTarget<int>(
                            onWillAccept: (data) {
                              if (data == null) return false;
                              return _game.canMoveIsland(data, index);
                            },
                            onAccept: (fromIndex) {
                              setState(() {
                                if (_game.moveIsland(fromIndex, index)) {
                                  _moveCount++;
                                  _checkWin();
                                }
                              });
                            },
                            builder: (context, candidateData, rejectedData) {
                              return Draggable<int>(
                                data: index,
                                onDragStarted: () {
                                  setState(() {
                                    final island = _game.getIsland(index);
                                    _draggedTileIds = island.map((i) => _game.tiles[i].correctIndex).toSet();
                                  });
                                },
                                onDragEnd: (details) {
                                  setState(() {
                                    _draggedTileIds = {};
                                  });
                                },
                                feedback: Builder(
                                  builder: (context) {
                                    final island = _game.getIsland(index);
                                    final startRow = index ~/ widget.gridSize;
                                    final startCol = index % widget.gridSize;
                                    
                                    return SizedBox(
                                      width: size,
                                      height: size,
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        children: island.map((islandIndex) {
                                          final row = islandIndex ~/ widget.gridSize;
                                          final col = islandIndex % widget.gridSize;
                                          final dRow = row - startRow;
                                          final dCol = col - startCol;
                                          
                                          return Positioned(
                                            left: dCol * size,
                                            top: dRow * size,
                                            child: Material(
                                              elevation: 4,
                                              color: Colors.transparent,
                                              child: _buildTileContent(islandIndex, size, isFeedback: true),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    );
                                  }
                                ),
                                childWhenDragging: Container(
                                  color: Colors.grey.withOpacity(0.2),
                                ),
                                child: _buildTileContent(index, size),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text(
                  'Kids Jigsaw Puzzle v1.0.4+5',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
