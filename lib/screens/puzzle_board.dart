import 'package:flutter/material.dart';

class PuzzleBoard extends StatelessWidget {
  const PuzzleBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Puzzle Board'),
      ),
      body: Center(
        child: AspectRatio(
          aspectRatio: 1.0,
          child: Image.asset(
            'sample-images/ale-seby-ski.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
