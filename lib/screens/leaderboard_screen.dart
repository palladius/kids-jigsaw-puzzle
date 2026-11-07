import 'package:flutter/material.dart';
import '../logic/puffin_login.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  String _filterGame = kKidsJigsawAppId;

  @override
  void initState() {
    super.initState();
    PuffinLogin.instance.syncScoresFromCloud();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0D1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121528),
        foregroundColor: Colors.white,
        title: const Text('🏆 Hall of Fame'),
        actions: const [
          PuffinLoginBadge(),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
            child: Column(
              children: [
                // Game filter pills: Kids Jigsaw Puzzle vs All Family Games
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildFilterChip(
                      label: '🧩 Kids Jigsaw Puzzle',
                      value: kKidsJigsawAppId,
                    ),
                    const SizedBox(width: 10),
                    _buildFilterChip(
                      label: '🌍 All Family Games',
                      value: 'ALL',
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: PuffinLeaderboardWidget(
                    filterGame: _filterGame,
                    limit: kTopTenLimit,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip({required String label, required String value}) {
    final selected = _filterGame == value;
    return ChoiceChip(
      label: Text(
        label,
        style: TextStyle(
          color: selected ? const Color(0xFF0A0C16) : Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 13,
        ),
      ),
      selected: selected,
      selectedColor: const Color(0xFFFACC15),
      backgroundColor: const Color(0xFF181C36),
      onSelected: (_) {
        setState(() {
          _filterGame = value;
        });
      },
    );
  }
}
