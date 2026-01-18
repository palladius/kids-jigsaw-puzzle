import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kids_jigsaw_puzzle/main.dart';

void main() {
  testWidgets('Difficulty selection and Grid generation test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify Main Menu has difficulty buttons
    expect(find.text('Kids Jigsaw Puzzle'), findsOneWidget);
    expect(find.text('Easy (4x4)'), findsOneWidget);
    expect(find.text('Medium (6x6)'), findsOneWidget);
    expect(find.text('Hard (8x8)'), findsOneWidget);

    // Tap 'Easy (4x4)'
    await tester.tap(find.text('Easy (4x4)'));
    await tester.pumpAndSettle();

    // Verify Puzzle Board title reflects difficulty
    expect(find.text('Puzzle Board (4x4)'), findsOneWidget);

    // Verify GridView exists
    expect(find.byType(GridView), findsOneWidget);

    // Verify 16 tiles are present (4x4)
    // We look for Image widgets inside the GridView
    expect(find.byType(Image), findsNWidgets(16));
  });
}
