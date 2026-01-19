import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class HighScore {
  final String name;
  final int score;
  final int gridSize;
  final int seconds;
  final DateTime date;

  HighScore({
    required this.name,
    required this.score,
    required this.gridSize,
    required this.seconds,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'score': score,
        'gridSize': gridSize,
        'seconds': seconds,
        'date': date.toIso8601String(),
      };

  factory HighScore.fromJson(Map<String, dynamic> json) => HighScore(
        name: json['name'],
        score: json['score'],
        gridSize: json['gridSize'],
        seconds: json['seconds'],
        date: DateTime.parse(json['date']),
      );
}

class HighScoreManager {
  static const String _key = 'high_scores';

  static int calculateScore(int gridSize, int seconds) {
    // Exponential complexity: gridSize^4 seems fair for the jump from 4x4 to 6x6
    // 4x4 -> 256
    // 6x6 -> 1296
    // 8x8 -> 4096
    final base = gridSize * gridSize * gridSize * gridSize;
    final timeFactor = 10000 / (seconds + 1);
    return (base * timeFactor).toInt();
  }

  static Future<void> saveScore(HighScore score) async {
    final prefs = await SharedPreferences.getInstance();
    final List<HighScore> scores = await getScores();
    scores.add(score);
    scores.sort((a, b) => b.score.compareTo(a.score));
    
    // Keep only top 10
    final topScores = scores.take(10).toList();
    
    final String encoded = jsonEncode(topScores.map((s) => s.toJson()).toList());
    await prefs.setString(_key, encoded);
  }

  static Future<List<HighScore>> getScores() async {
    final prefs = await SharedPreferences.getInstance();
    final String? encoded = prefs.getString(_key);
    if (encoded == null) return [];
    
    final List<dynamic> decoded = jsonDecode(encoded);
    return decoded.map((item) => HighScore.fromJson(item)).toList();
  }
}
