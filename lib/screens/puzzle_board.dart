import 'package:flutter/material.dart';

class PuzzleBoard extends StatelessWidget {
  const PuzzleBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Puzzle Board'),
      ),
      body: const Center(
        child: Text(
          'Puzzle Grid will go here',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
