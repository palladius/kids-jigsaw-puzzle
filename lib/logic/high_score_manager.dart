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

  static int calculateScore(int gridSize, int seconds, {int penalty = 0}) {
    // Exponential complexity: gridSize^4 seems fair for the jump from 4x4 to 6x6
    // 4x4 -> 256
    // 6x6 -> 1296
    // 8x8 -> 4096
    final base = gridSize * gridSize * gridSize * gridSize;
    final timeFactor = 10000 / (seconds + 1);
    final rawScore = (base * timeFactor).toInt();
    return (rawScore - penalty).clamp(0, 999999999);
  }

  static Future<void> saveScore(HighScore newScore) async {
    final prefs = await SharedPreferences.getInstance();
    final List<HighScore> scores = await getScores();
    
    // Find if this player already has a score
    final existingIndex = scores.indexWhere(
      (s) => s.name.toLowerCase() == newScore.name.toLowerCase()
    );

    if (existingIndex != -1) {
      // Only update if the new score is higher
      if (newScore.score > scores[existingIndex].score) {
        scores[existingIndex] = newScore;
      } else {
        // New score is not better, don't save anything
        return;
      }
    } else {
      // New player, add them
      scores.add(newScore);
    }

    // Sort by score descending
    scores.sort((a, b) => b.score.compareTo(a.score));
    
    // Keep only top 10 unique players
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

  static Future<List<String>> getUniqueNames() async {
    final scores = await getScores();
    return scores.map((s) => s.name).toSet().toList();
  }
}
