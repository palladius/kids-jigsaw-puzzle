import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'puffin_login.dart';

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

  static Future<void> saveScore(
    HighScore newScore, {
    String? startedAt,
    int? moves,
    int? tipsUsed,
    String? imagePath,
  }) async {
    // 1. Also submit to PuffinLogin (local outbox + Cloud Firestore `ror-goldie` / `puffin-login`)
    final imageSlug = (imagePath ?? 'puzzle')
        .split('/')
        .last
        .split('.')
        .first;
    final resolvedProfileId = PuffinLogin.instance.currentUser?.id ??
        normalizePuffinProfileId(newScore.name, allowNull: true);
    final profile = getPuffinProfileById(resolvedProfileId);

    await PuffinLogin.instance.submitScore(
      score: newScore.score,
      durationSec: newScore.seconds,
      startedAt: startedAt,
      endedAt: newScore.date.toUtc().toIso8601String(),
      playerId: resolvedProfileId,
      summaryText:
          '${profile.displayName} solved ${newScore.gridSize}x${newScore.gridSize} ($imageSlug) in ${newScore.seconds}s!',
      extra: <String, dynamic>{
        'difficulty': '${newScore.gridSize}x${newScore.gridSize}',
        'grid': '${newScore.gridSize}x${newScore.gridSize}',
        'grid_size': newScore.gridSize,
        'pieces': newScore.gridSize * newScore.gridSize,
        'seconds': newScore.seconds,
        'duration_sec': newScore.seconds,
        'schema_hash': 'jigsaw_${imageSlug}_${newScore.gridSize}x${newScore.gridSize}',
        if (moves != null) 'moves': moves,
        if (tipsUsed != null) 'tips_used': tipsUsed,
        if (tipsUsed != null) 'hints': tipsUsed,
      },
    );

    // 2. Preserve legacy `high_scores` SharedPreferences list
    final prefs = await SharedPreferences.getInstance();
    final List<HighScore> scores = await getScores();

    final existingIndex = scores.indexWhere(
      (s) => s.name.toLowerCase() == newScore.name.toLowerCase(),
    );

    if (existingIndex != -1) {
      if (newScore.score > scores[existingIndex].score) {
        scores[existingIndex] = newScore;
      } else {
        return;
      }
    } else {
      scores.add(newScore);
    }

    scores.sort((a, b) => b.score.compareTo(a.score));
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
    final puffinNames = kPuffinProfiles.map((p) => p.shortName);
    return <String>{...puffinNames, ...scores.map((s) => s.name)}.toList();
  }
}
