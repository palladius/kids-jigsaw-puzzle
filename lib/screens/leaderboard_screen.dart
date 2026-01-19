import 'package:flutter/material.dart';
import '../logic/high_score_manager.dart';
import 'package:intl/intl.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🏆 Hall of Fame'),
      ),
      body: FutureBuilder<List<HighScore>>(
        future: HighScoreManager.getScores(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          final scores = snapshot.data ?? [];
          
          if (scores.isEmpty) {
            return const Center(
              child: Text(
                'No scores yet. Go play!',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            itemCount: scores.length,
            itemBuilder: (context, index) {
              final score = scores[index];
              final dateStr = DateFormat('yyyy-MM-dd').format(score.date);
              
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: _getRankColor(index),
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  title: Text(
                    score.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  subtitle: Text('Grid: ${score.gridSize}x${score.gridSize} | Time: ${score.seconds}s | $dateStr'),
                  trailing: Text(
                    '${score.score}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Color _getRankColor(int index) {
    switch (index) {
      case 0: return Colors.amber; // Gold
      case 1: return Colors.grey;  // Silver
      case 2: return Colors.brown; // Bronze
      default: return Colors.blueGrey;
    }
  }
}
