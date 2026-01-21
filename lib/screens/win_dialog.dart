import 'package:flutter/material.dart';
import 'package:kids_jigsaw_puzzle/logic/high_score_manager.dart';

class WinDialog extends StatefulWidget {
  final int score;
  final int seconds;
  final int gridSize;
  final String imagePath;
  final VoidCallback onPlayAgain;
  final VoidCallback onMenu;

  const WinDialog({
    super.key,
    required this.score,
    required this.seconds,
    required this.gridSize,
    required this.imagePath,
    required this.onPlayAgain,
    required this.onMenu,
  });

  @override
  State<WinDialog> createState() => _WinDialogState();
}

class _WinDialogState extends State<WinDialog> {
  String _name = '';
  bool _isSaved = false;
  late Future<List<String>> _existingNamesFuture;

  @override
  void initState() {
    super.initState();
    _existingNamesFuture = HighScoreManager.getUniqueNames();
  }

  Future<void> _handleSave() async {
    final nameToSave = _name.trim().isEmpty ? 'Anonymous' : _name.trim();
    
    await HighScoreManager.saveScore(HighScore(
      name: nameToSave,
      score: widget.score,
      gridSize: widget.gridSize,
      seconds: widget.seconds,
      date: DateTime.now(),
    ));

    setState(() {
      _isSaved = true;
    });

    // Wait 3 seconds then go to menu
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        widget.onMenu();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // If saved, show the "Thanks" view
    if (_isSaved) {
      return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 32.0),
          child: SizedBox(
            width: 450,
            child: AlertDialog(
              title: Text('🎉 Thanks, $_name!'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('That was awesome!', style: TextStyle(fontSize: 18)),
                  const SizedBox(height: 20),
                   Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 4),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        widget.imagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text('Going back to menu...', style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey)),
                ],
              ),
            ),
          ),
        ),
      );
    }

    // Default view: Input Name
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 32.0),
        child: SizedBox(
          width: 350,
          child: AlertDialog(
            title: const Text('🏆 BRAVO!'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('You solved it in ${widget.seconds} seconds!'),
                const SizedBox(height: 8),
                Text('Score: ${widget.score}', 
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blue),
                ),
                const SizedBox(height: 16),
                const Text('Enter your name for the Hall of Fame:'),
                const SizedBox(height: 8),
                FutureBuilder<List<String>>(
                  future: _existingNamesFuture,
                  builder: (context, snapshot) {
                    final existingNames = snapshot.data ?? [];
                    return Autocomplete<String>(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        if (textEditingValue.text.isEmpty) {
                          return const Iterable<String>.empty();
                        }
                        return existingNames.where((String option) {
                          return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
                        });
                      },
                      onSelected: (String selection) {
                        setState(() {
                          _name = selection;
                        });
                        // Optional: Auto-save on selection? No, let them click save.
                      },
                      fieldViewBuilder: (context, textController, focusNode, onFieldSubmitted) {
                        // Keep internal state in sync with controller
                        textController.addListener(() {
                          _name = textController.text;
                        });
                        
                        return TextField(
                          controller: textController,
                          focusNode: focusNode,
                          autofocus: true, // Focus immediately!
                          decoration: const InputDecoration(
                            hintText: 'Your Name',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.person),
                          ),
                          onSubmitted: (_) => _handleSave(), // Allow 'Enter' to save
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            actions: [
              // Hide Play Again initially, prioritize Save
              ElevatedButton.icon(
                onPressed: _handleSave,
                icon: const Icon(Icons.save),
                label: const Text('Save & Celebrate'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
