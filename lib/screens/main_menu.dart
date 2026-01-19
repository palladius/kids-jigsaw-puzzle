import 'dart:math';
import 'package:flutter/material.dart';
import 'puzzle_board.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  static const List<String> _images = [
    'sample-images/ale-seby-ski.png',
    'sample-images/ale-seby-xmas-cropped.png',
    'sample-images/ale-seby-xmas.png',
    'sample-images/family-pijama-estensi.png',
  ];

  String _getRandomImage() {
    return _images[Random().nextInt(_images.length)];
  }

  @override
  Widget build(BuildContext context) {
    const bool isDebug = String.fromEnvironment('GAME_DEBUG') == 'true';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kids Jigsaw Puzzle'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome!',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              if (isDebug) ...[
                _buildDifficultyButton(context, 'DEBUG (2x2)', 2),
                const SizedBox(height: 20),
              ],
              _buildDifficultyButton(context, 'Easy (4x4)', 4),
              const SizedBox(height: 20),
              _buildDifficultyButton(context, 'Medium (6x6)', 6),
              const SizedBox(height: 20),
              _buildDifficultyButton(context, 'Hard (8x8)', 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDifficultyButton(BuildContext context, String label, int gridSize) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PuzzleBoard(
              gridSize: gridSize,
              imagePath: _getRandomImage(),
            ),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        textStyle: const TextStyle(fontSize: 24),
      ),
      child: Text(label),
    );
  }
}
