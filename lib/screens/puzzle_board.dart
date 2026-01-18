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

  Widget _buildTileContent(PuzzleTile tile, double size, {bool isFeedback = false}) {
    final fullImageSize = size * widget.gridSize;
    final int correctRow = tile.correctIndex ~/ widget.gridSize;
    final int correctCol = tile.correctIndex % widget.gridSize;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        border: Border.all(
          color: isFeedback ? Colors.yellow : Colors.white,
          width: isFeedback ? 2.0 : 0.5,
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
                _stopwatch.reset();
                _stopwatch.start();
              });
            },
          ),
        ],
      ),
      body: Center(
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

              return LayoutBuilder(
                builder: (context, constraints) {
                  final size = constraints.maxWidth;

                  return DragTarget<int>(
                    onWillAccept: (data) => data != index,
                    onAccept: (fromIndex) {
                      setState(() {
                        _game.swap(fromIndex, index);
                        _checkWin();
                      });
                    },
                    builder: (context, candidateData, rejectedData) {
                      return Draggable<int>(
                        data: index,
                        feedback: Material(
                          elevation: 4,
                          child: _buildTileContent(tile, size, isFeedback: true),
                        ),
                        childWhenDragging: Container(
                          color: Colors.grey.withOpacity(0.2),
                        ),
                        child: _buildTileContent(tile, size),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
