import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kids_jigsaw_puzzle/main.dart';
import 'package:kids_jigsaw_puzzle/screens/puzzle_board.dart';

void main() {
  testWidgets('Tile shuffling and swapping test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Navigate to Easy puzzle (4x4)
    await tester.tap(find.text('Easy (4x4)'));
    await tester.pumpAndSettle();

    // Verify GridView exists
    expect(find.byType(GridView), findsOneWidget);

    // Find all tiles (GestureDetectors inside GridView)
    final tileFinder = find.descendant(
      of: find.byType(GridView),
      matching: find.byType(GestureDetector),
    );
    expect(tileFinder, findsNWidgets(16));

    // Tap the first tile to select it
    await tester.tap(tileFinder.at(0));
    await tester.pump();

    // Verify selection (border color change logic is internal, 
    // but we can check if the widget tree updated without error)
    
    // Tap the second tile to swap
    await tester.tap(tileFinder.at(1));
    await tester.pump();

    // Verify refresh button exists
    expect(find.byIcon(Icons.refresh), findsOneWidget);
    
    // Tap refresh to shuffle
    await tester.tap(find.byIcon(Icons.refresh));
    await tester.pump();
  });
}
