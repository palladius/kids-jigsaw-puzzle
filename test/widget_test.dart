import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kids_jigsaw_puzzle/main.dart';

void main() {
  testWidgets('Main menu and Puzzle Board image test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify Main Menu
    expect(find.text('Kids Jigsaw Puzzle'), findsOneWidget);
    expect(find.text('Play'), findsOneWidget);

    // Navigate to Puzzle Board
    await tester.tap(find.text('Play'));
    await tester.pumpAndSettle();

    // Verify Puzzle Board title
    expect(find.text('Puzzle Board'), findsOneWidget);

    // Verify Image is present
    // Note: In widget tests, Image.asset doesn't actually load the bytes, 
    // but we can check if the widget exists.
    expect(find.byType(Image), findsOneWidget);
  });
}
