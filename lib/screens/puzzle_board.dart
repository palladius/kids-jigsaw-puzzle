import 'package:flutter/material.dart';

class PuzzleBoard extends StatelessWidget {
  final int gridSize;

  const PuzzleBoard({super.key, required this.gridSize});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Puzzle Board (${gridSize}x$gridSize)'),
      ),
      body: Center(
        child: AspectRatio(
          aspectRatio: 1.0,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: gridSize * gridSize,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: gridSize,
            ),
            itemBuilder: (context, index) {
              // Calculate row and column
              final int row = index ~/ gridSize;
              final int col = index % gridSize;

              return Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 0.5),
                ),
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: 1000, // Arbitrary large size to ensure high quality
                    height: 1000,
                    child: ClipRect(
                      child: Align(
                        alignment: Alignment(
                          // Map 0..gridSize-1 to -1.0..1.0
                          (col / (gridSize - 1)) * 2 - 1,
                          (row / (gridSize - 1)) * 2 - 1,
                        ),
                        widthFactor: 1.0 / gridSize,
                        heightFactor: 1.0 / gridSize,
                        child: Image.asset(
                          'sample-images/ale-seby-ski.png',
                          fit: BoxFit.cover,
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
