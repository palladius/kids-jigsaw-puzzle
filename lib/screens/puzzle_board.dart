import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

import 'dart:async';
import 'package:flutter/services.dart';
import 'package:kids_jigsaw_puzzle/logic/puzzle_logic.dart';
import 'package:kids_jigsaw_puzzle/logic/high_score_manager.dart';
import 'package:kids_jigsaw_puzzle/screens/win_dialog.dart';

class PuzzleBoard extends StatefulWidget {
  final int gridSize;
  final String imagePath;

  const PuzzleBoard({
    super.key, 
    required this.gridSize,
    required this.imagePath,
  });

  @override
  State<PuzzleBoard> createState() => _PuzzleBoardState();
}

class _PuzzleBoardState extends State<PuzzleBoard> {
  late PuzzleGame _game;
  final Stopwatch _stopwatch = Stopwatch();
  late ConfettiController _confettiController;
  Set<int> _draggedTileIds = {};
  int _moveCount = 0;
  bool _isXrayEnabled = false;
  List<int> _suggestedSwapIndices = [];
  Timer? _suggestionTimer;

  @override
  void initState() {
    super.initState();
    _game = PuzzleGame(gridSize: widget.gridSize);
    _game.shuffle();
    _stopwatch.start();
    _confettiController = ConfettiController(duration: const Duration(seconds: 5));
  }

  @override
  void dispose() {
    _suggestionTimer?.cancel();
    _confettiController.dispose();
    super.dispose();
  }

  void _checkWin() {
    if (_game.isSolved()) {
      _stopwatch.stop();
      _confettiController.play();
      Future.delayed(const Duration(milliseconds: 500), () {
        _showWinDialog();
      });
    }
  }

  void _showWinDialog() async {
    final duration = _stopwatch.elapsed;
    final seconds = duration.inSeconds;
    final score = HighScoreManager.calculateScore(widget.gridSize, seconds);

    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => WinDialog(
        score: score,
        seconds: seconds,
        gridSize: widget.gridSize,
        imagePath: widget.imagePath,
        onPlayAgain: () {
          Navigator.pop(context); // Close dialog
          setState(() {
            _game.shuffle();
            _moveCount = 0;
            _stopwatch.reset();
            _stopwatch.start();
          });
        },
        onMenu: () {
          Navigator.pop(context); // Close dialog
          Navigator.pop(context); // Back to menu
        },
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

    final isCorrect = tile.currentIndex == tile.correctIndex;
    final isSuggested = _suggestedSwapIndices.contains(index);

    final topConnected = row > 0 && isConnected(index - widget.gridSize);
    final bottomConnected = row < widget.gridSize - 1 && isConnected(index + widget.gridSize);
    final leftConnected = col > 0 && isConnected(index - 1);
    final rightConnected = col < widget.gridSize - 1 && isConnected(index + 1);

    Color borderColor;
    double borderWidth;

    if (isSuggested) {
       borderColor = Colors.blueAccent;
       borderWidth = 4.0;
    } else if (_isXrayEnabled && isCorrect) {
      borderColor = Colors.green;
      borderWidth = 3.0;
    } else {
      borderColor = isFeedback 
        ? Colors.yellow 
        : Colors.white.withOpacity(0.8);
      borderWidth = isFeedback ? 3.0 : 1.0;
    }
    
    final borderSide = BorderSide(color: borderColor, width: borderWidth);
    
    final transparentSide = BorderSide(
      color: Colors.transparent,
      width: 0.0,
    );

    return Opacity(
      opacity: (_isXrayEnabled && !isCorrect && !isSuggested) ? 0.5 : 1.0,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          border: Border(
            top: topConnected ? transparentSide : borderSide,
            bottom: bottomConnected ? transparentSide : borderSide,
            left: leftConnected ? transparentSide : borderSide,
            right: rightConnected ? transparentSide : borderSide,
          ),
          boxShadow: isSuggested ? [
             const BoxShadow(
               color: Colors.blueAccent,
               blurRadius: 10,
               spreadRadius: 2,
             )
          ] : null,
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
              widget.imagePath,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  void _showSuggestion() {
    setState(() {
      _suggestedSwapIndices = _game.getSwapSuggestion();
    });
    
    _suggestionTimer?.cancel();
    _suggestionTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _suggestedSwapIndices = [];
        });
      }
    });
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Controls & Legend"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
             ListTile(
               leading: Icon(Icons.swap_horiz, color: Colors.blueAccent),
               title: Text("T - Tip / Suggestion"),
               subtitle: Text("Highlights two tiles to swap."),
             ),
             ListTile(
               leading: Icon(Icons.visibility, color: Colors.green),
               title: Text("Space - X-ray Vision"),
               subtitle: Text("Hold to see correct tiles."),
             ),
             ListTile(
               leading: Icon(Icons.help_outline),
               title: Text("H - Help"),
               subtitle: Text("Show this dialog."),
             ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Got it!"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: true,
      onKey: (node, event) {
        if (event is RawKeyDownEvent) {
          if (event.logicalKey == LogicalKeyboardKey.space) {
             if (!_isXrayEnabled) setState(() => _isXrayEnabled = true);
             return KeyEventResult.handled;
          } else if (event.logicalKey == LogicalKeyboardKey.keyT) {
             _showSuggestion();
             return KeyEventResult.handled;
          } else if (event.logicalKey == LogicalKeyboardKey.keyH) {
             _showHelpDialog();
             return KeyEventResult.handled;
          }
        } else if (event is RawKeyUpEvent) {
          if (event.logicalKey == LogicalKeyboardKey.space) {
             setState(() => _isXrayEnabled = false);
             return KeyEventResult.handled;
          }
        }
        return KeyEventResult.ignored;
      },
      child: Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text('Puzzle Board (${widget.gridSize}x${widget.gridSize})'),
            actions: [
              IconButton(
                icon: const Icon(Icons.lightbulb_outline),
                tooltip: "Tip (T)",
                onPressed: _showSuggestion,
              ),
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
              GestureDetector(
                onTapDown: (_) => setState(() => _isXrayEnabled = true),
                onTapUp: (_) => setState(() => _isXrayEnabled = false),
                onTapCancel: () => setState(() => _isXrayEnabled = false),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  padding: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.greenAccent.withOpacity(_isXrayEnabled ? 0.8 : 0.4),
                        blurRadius: _isXrayEnabled ? 15.0 : 8.0,
                        spreadRadius: _isXrayEnabled ? 4.0 : 1.0,
                      ),
                    ],
                  ),
                  child: const Icon(Icons.visibility, color: Colors.white, size: 32),
                ),
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
                          final isBeingDragged = _draggedTileIds.contains(tile.correctIndex);

                          return LayoutBuilder(
                            key: ValueKey('tile-${tile.correctIndex}'),
                            builder: (context, constraints) {
                              final size = constraints.maxWidth;

                              return DragTarget<int>(
                                onWillAccept: (data) {
                                  if (data == null) return false;
                                  final canMove = _game.canMoveIsland(data, index);
                                  return canMove;
                                },
                                onAccept: (fromIndex) {
                                  debugPrint('Accepting move from $fromIndex to $index');
                                  setState(() {
                                    _draggedTileIds = {}; // Aggressively clear to prevent "white tiles"
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
                                      debugPrint('Drag started for tile at $index (ID: ${tile.correctIndex})');
                                      setState(() {
                                        final island = _game.getIsland(index);
                                        _draggedTileIds = island.map((i) => _game.tiles[i].correctIndex).toSet();
                                        debugPrint('Island IDs: $_draggedTileIds');
                                      });
                                    },
                                    onDragEnd: (details) {
                                      debugPrint('Drag ended for tile at $index');
                                      setState(() {
                                        _draggedTileIds = {};
                                      });
                                    },
                                    onDraggableCanceled: (velocity, offset) {
                                      debugPrint('Drag canceled for tile at $index');
                                      setState(() {
                                        _draggedTileIds = {};
                                      });
                                    },
                                    onDragCompleted: () {
                                      debugPrint('Drag completed for tile at $index');
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
                                      width: size,
                                      height: size,
                                      color: Colors.grey.withOpacity(0.2),
                                    ),
                                    child: isBeingDragged
                                        ? Container(
                                            width: size,
                                            height: size,
                                            color: Colors.grey.withOpacity(0.2),
                                          )
                                        : _buildTileContent(index, size),
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
                      'Kids Jigsaw Puzzle v1.1.10+23',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: false,
            colors: const [
              Colors.green,
              Colors.blue,
              Colors.pink,
              Colors.orange,
              Colors.purple,
              Colors.yellow,
            ],
          ),
        ),
      ],
    ));
  }
}
