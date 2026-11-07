import 'package:flutter/material.dart';
import 'package:kids_jigsaw_puzzle/logic/high_score_manager.dart';
import 'package:kids_jigsaw_puzzle/logic/puffin_login.dart';
import 'package:kids_jigsaw_puzzle/logic/puffin_bridge_stub.dart'
    if (dart.library.js_interop) 'package:kids_jigsaw_puzzle/logic/puffin_bridge_web.dart';

class WinDialog extends StatefulWidget {
  final int score;
  final int seconds;
  final int gridSize;
  final String imagePath;
  final String? startedAt;
  final int? moves;
  final int? tipsUsed;
  final VoidCallback onPlayAgain;
  final VoidCallback onMenu;

  const WinDialog({
    super.key,
    required this.score,
    required this.seconds,
    required this.gridSize,
    required this.imagePath,
    this.startedAt,
    this.moves,
    this.tipsUsed,
    required this.onPlayAgain,
    required this.onMenu,
  });

  @override
  State<WinDialog> createState() => _WinDialogState();
}

class _WinDialogState extends State<WinDialog> {
  bool _scoreSubmitted = false;

  @override
  void initState() {
    super.initState();
    // Reveal Hall of Fame at Game Over (Rule #4 of puffin-login skill)
    PuffinPlatformBridge.setWebHallOfFameVisible(true);
    _autoSaveForActiveHero();
  }

  Future<void> _autoSaveForActiveHero() async {
    if (_scoreSubmitted) return;
    _scoreSubmitted = true;

    final user = PuffinLogin.instance.currentUser;
    final heroName = user?.shortName ?? 'Guest';

    await HighScoreManager.saveScore(
      HighScore(
        name: heroName,
        score: widget.score,
        gridSize: widget.gridSize,
        seconds: widget.seconds,
        date: DateTime.now(),
      ),
      startedAt: widget.startedAt,
      moves: widget.moves,
      tipsUsed: widget.tipsUsed,
      imagePath: widget.imagePath,
    );

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: PuffinLogin.instance,
      builder: (context, _) {
        final user = PuffinLogin.instance.currentUser ?? getPuffinProfileById('guest');
        final isIt = PuffinLogin.instance.lang == 'it';

        return Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 460),
              child: AlertDialog(
                backgroundColor: const Color(0xFF121528),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: user.color, width: 2.5),
                ),
                title: Row(
                  children: [
                    PuffinAvatarWidget(
                      profile: user,
                      size: 44,
                      zoomedOut: true,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        '🏆 BRAVO, ${user.shortName}!',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ],
                ),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        isIt
                            ? 'Risolto in ${widget.seconds} secondi!'
                            : 'You solved it in ${widget.seconds} seconds!',
                        style: const TextStyle(color: Color(0xFFCBD5E1), fontSize: 15),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Score: ${widget.score}',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 22,
                          color: user.color,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Center(
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            border: Border.all(color: user.color, width: 3),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(9),
                            child: Image.asset(
                              widget.imagePath,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        '🏆 Hall of Fame (Top 10)',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const PuffinLeaderboardWidget(
                        filterGame: kKidsJigsawAppId,
                        limit: 5,
                        shrinkWrap: true,
                      ),
                    ],
                  ),
                ),
                actionsAlignment: MainAxisAlignment.spaceBetween,
                actions: [
                  TextButton.icon(
                    onPressed: widget.onMenu,
                    icon: const Icon(Icons.home, color: Colors.white70),
                    label: Text(
                      isIt ? 'Menu' : 'Main Menu',
                      style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: widget.onPlayAgain,
                    icon: const Icon(Icons.replay),
                    label: Text(isIt ? 'Gioca ancora' : 'Play Again'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: user.color,
                      foregroundColor: const Color(0xFF0A0C16),
                      textStyle: const TextStyle(fontWeight: FontWeight.w900),
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
