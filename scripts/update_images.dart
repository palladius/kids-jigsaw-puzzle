import 'dart:io';

void main() {
  final directory = Directory('assets/images');
  if (!directory.existsSync()) {
    print('Error: assets/images directory not found.');
    exit(1);
  }

  final images = directory
      .listSync()
      .where((file) => file is File && (file.path.endsWith('.png') || file.path.endsWith('.jpg') || file.path.endsWith('.jpeg')))
      .map((file) => "    'assets/images/${file.path.split(Platform.pathSeparator).last}',")
      .toList();

  images.sort();

  final file = File('lib/screens/main_menu.dart');
  if (!file.existsSync()) {
    print('Error: lib/screens/main_menu.dart not found.');
    exit(1);
  }

  final lines = file.readAsLinesSync();
  final newLines = <String>[];
  bool inImagesList = false;
  bool imagesUpdated = false;

  for (var line in lines) {
    if (line.contains('static const List<String> _images = [')) {
      inImagesList = true;
      newLines.add(line);
      newLines.addAll(images);
      imagesUpdated = true;
      continue;
    }

    if (inImagesList) {
      if (line.contains('];')) {
        inImagesList = false;
        newLines.add(line);
      }
      continue;
    }

    newLines.add(line);
  }

  if (imagesUpdated) {
    file.writeAsStringSync(newLines.join('\n') + '\n');
    print('Successfully updated lib/screens/main_menu.dart with ${images.length} images.');
  } else {
    print('Error: Could not find _images list in lib/screens/main_menu.dart');
    exit(1);
  }
}
