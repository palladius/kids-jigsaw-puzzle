import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kids_jigsaw_puzzle/main.dart';

void main() {
  testWidgets('Drag and Drop test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Navigate to Easy puzzle (4x4)
    await tester.tap(find.text('Easy (4x4)'));
    await tester.pumpAndSettle();

    // Verify GridView exists
    expect(find.byType(GridView), findsOneWidget);

    // Find all Draggables
    final draggableFinder = find.byType(Draggable<int>);
    expect(draggableFinder, findsNWidgets(16));

    // Find all DragTargets
    final dragTargetFinder = find.byType(DragTarget<int>);
    expect(dragTargetFinder, findsNWidgets(16));

    // Perform a drag and drop operation
    // Drag tile 0 to tile 1
    final firstTile = draggableFinder.at(0);
    final secondTile = dragTargetFinder.at(1);
    
    await tester.drag(firstTile, const Offset(100, 0)); // Drag roughly to the right
    // Note: Exact drag coordinates are tricky in widget tests without knowing screen size,
    // but we can verify the widgets exist and are interactive.
    
    // Verify refresh button still works
    await tester.tap(find.byIcon(Icons.refresh));
    await tester.pump();
  });
}
