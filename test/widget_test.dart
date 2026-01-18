import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kids_jigsaw_puzzle/main.dart';

void main() {
  testWidgets('Main menu smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the title is displayed.
    expect(find.text('Kids Jigsaw Puzzle'), findsOneWidget);
    expect(find.text('Welcome!'), findsOneWidget);
    expect(find.text('Play'), findsOneWidget);

    // Tap the 'Play' button and trigger a frame.
    await tester.tap(find.text('Play'));
    await tester.pumpAndSettle();

    // Verify that we navigated to the Puzzle Board.
    expect(find.text('Puzzle Board'), findsOneWidget);
    expect(find.text('Puzzle Grid will go here'), findsOneWidget);
  });
}
