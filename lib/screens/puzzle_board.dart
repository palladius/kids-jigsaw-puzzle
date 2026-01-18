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
  int? _selectedIndex;

  @override
  void initState() {
    super.initState();
    _game = PuzzleGame(gridSize: widget.gridSize);
    _game.shuffle();
  }

  void _handleTileTap(int index) {
    setState(() {
      if (_selectedIndex == null) {
        // Select first tile
        _selectedIndex = index;
      } else if (_selectedIndex == index) {
        // Deselect if same tile tapped
        _selectedIndex = null;
      } else {
        // Swap tiles
        _game.swap(_selectedIndex!, index);
        _selectedIndex = null;
      }
    });
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
                _selectedIndex = null;
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
              // Use correctIndex to determine which part of the image to show
              final int correctRow = tile.correctIndex ~/ widget.gridSize;
              final int correctCol = tile.correctIndex % widget.gridSize;

              final isSelected = _selectedIndex == index;

              return GestureDetector(
                onTap: () => _handleTileTap(index),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isSelected ? Colors.yellow : Colors.white,
                      width: isSelected ? 3.0 : 0.5,
                    ),
                  ),
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: 1000,
                      height: 1000,
                      child: ClipRect(
                        child: Align(
                          alignment: Alignment(
                            (correctCol / (widget.gridSize - 1)) * 2 - 1,
                            (correctRow / (widget.gridSize - 1)) * 2 - 1,
                          ),
                          widthFactor: 1.0 / widget.gridSize,
                          heightFactor: 1.0 / widget.gridSize,
                          child: Image.asset(
                            'sample-images/ale-seby-ski.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
