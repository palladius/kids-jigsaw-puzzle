import 'dart:math';
import 'package:flutter/material.dart';
import 'puzzle_board.dart';
import 'leaderboard_screen.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  static const List<String> _images = [
    'assets/images/ale-seby-ski.png',
    'assets/images/ale-seby-xmas-cropped.png',
    'assets/images/ale-seby-xmas.png',
    'assets/images/family-pijama-estensi.png',
    'assets/images/aj-with-giraffe.png',
    'assets/images/arca-di-noe-torta-compleanno.png',
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
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LeaderboardScreen()),
                  );
                },
                icon: const Icon(Icons.emoji_events),
                label: const Text('Hall of Fame'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
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
