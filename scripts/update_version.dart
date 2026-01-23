import 'dart:io';

void main() {
  final pubspec = File('pubspec.yaml');
  if (!pubspec.existsSync()) {
    print('Error: pubspec.yaml not found');
    exit(1);
  }
  final lines = pubspec.readAsLinesSync();
  String versionLine = lines.firstWhere((l) => l.startsWith('version: '), orElse: () => '');
  if (versionLine.isEmpty) {
    print('Error: version not found in pubspec.yaml');
    exit(1);
  }
  // version: 1.1.15+28
  final versionString = versionLine.split(' ')[1].trim();

  final content = '''
// GENERATED CODE - DO NOT MODIFY BY HAND
// Read from pubspec.yaml

class AppConstants {
  static const String rawVersion = "$versionString";

  static String get version => rawVersion.split('+').first;
  static String get build => rawVersion.contains('+') ? rawVersion.split('+').last : '';
  static String get fullVersion => rawVersion;
}
''';

  File('lib/constants.dart').writeAsStringSync(content);
  print('Updated lib/constants.dart to $versionString');
}
