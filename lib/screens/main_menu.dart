import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'puzzle_board.dart';
import 'leaderboard_screen.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  static const List<String> _images = [
    'assets/images/aj-megapuzzle.png',
    'assets/images/aj-with-giraffe.png',
    'assets/images/ale-animale-mexico-cool.png',
    'assets/images/ale-bici-meilen.png',
    'assets/images/ale-gondola.png',
    'assets/images/ale-maglietta-ele.png',
    'assets/images/ale-papa-mexico-pool.png',
    'assets/images/ale-pupurabbu.png',
    'assets/images/ale-seby-android.png',
    'assets/images/ale-seby-bordo-colorato.png',
    'assets/images/ale-seby-google-chess3.png',
    'assets/images/ale-seby-google-logo.png',
    'assets/images/ale-seby-halloween.png',
    'assets/images/ale-seby-kate-argenta-ele-jc.png',
    'assets/images/ale-seby-kate-venezia.png',
    'assets/images/ale-seby-lederhosen-g.png',
    'assets/images/ale-seby-mexico.png',
    'assets/images/ale-seby-palla-bici.png',
    'assets/images/ale-seby-scacchi-locarno.png',
    'assets/images/ale-seby-scemi-tulum.png',
    'assets/images/ale-seby-ski.png',
    'assets/images/ale-seby-slitta.png',
    'assets/images/ale-seby-tandem-wow.png',
    'assets/images/ale-seby-train.png',
    'assets/images/ale-seby-tulum.png',
    'assets/images/ale-seby-uxmal.png',
    'assets/images/ale-seby-xmas-cropped.png',
    'assets/images/ale-seby-xmas.png',
    'assets/images/ale-spiaggia-mexico.png',
    'assets/images/ale-tieffenbrunnen.png',
    'assets/images/ale-xmas-jumper.png',
    'assets/images/arca-di-noe-torta-compleanno.png',
    'assets/images/comacchio-3ponti.png',
    'assets/images/family-in-tulum.png',
    'assets/images/family-pijama-estensi.png',
    'assets/images/family-santa-2024.png',
    'assets/images/family-silvester-lauf.png',
    'assets/images/family-xmas-presents.png',
    'assets/images/gdg-zurich-jan26.png',
    'assets/images/logo.png',
    'assets/images/lucy-bimbi-ikea.png',
    'assets/images/lucy-kate-ale-rialto.png',
    'assets/images/lucy-seby-estate-inverno.png',
    'assets/images/lucy-venezia-kate-bimbi-rialto.png',
    'assets/images/pupurabbu.png',
    'assets/images/puzzle-42.png',
    'assets/images/reindeers-in-stadelhofen.png',
    'assets/images/reindeers-polar-express.png',
    'assets/images/ricc-ale-seby-rubycon.png',
    'assets/images/ricc-bimbi-lugano.png',
    'assets/images/ricc-lucy-albero-lde.png',
    'assets/images/seby-in-space.png',
    'assets/images/seby-palla-di-natale.png',
    'assets/images/seby-puzzle.png',
    'assets/images/seby-sgarrupato.png',
    'assets/images/seby-ski-italy.png',
    'assets/images/zurich-tram4.png',
  ];

  String? _selectedImagePath; // null means random

  String _getEffectiveImage() {
    if (_selectedImagePath != null) return _selectedImagePath!;
    return _images[Random().nextInt(_images.length)];
  }

  @override
  Widget build(BuildContext context) {
    const bool isDebug = String.fromEnvironment('GAME_DEBUG') == 'true';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kids Jigsaw Puzzle'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome!',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              
              // Image Selector Section
              const Text('Select Image:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
              const SizedBox(height: 10),
              SizedBox(
                height: 120,
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(
                    dragDevices: {
                      PointerDeviceKind.touch,
                      PointerDeviceKind.mouse,
                      PointerDeviceKind.trackpad,
                    },
                  ),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      _buildImageThumbnail(null, 'Random'),
                      ..._images.map((path) => _buildImageThumbnail(path, path.split('/').last.split('.').first)),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 40),
              if (isDebug) ...[
                _buildDifficultyButton(context, 'DEBUG (2x2)', 2),
                const SizedBox(height: 20),
              ],
              _buildDifficultyButton(context, 'Easy (4x4)', 4),
              const SizedBox(height: 20),
              _buildDifficultyButton(context, 'Medium (6x6)', 6),
              const SizedBox(height: 20),
              _buildDifficultyButton(context, 'Hard (8x8)', 8),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LeaderboardScreen()),
                  );
                },
                icon: const Icon(Icons.emoji_events),
                label: const Text('Hall of Fame'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageThumbnail(String? path, String label) {
    final isSelected = _selectedImagePath == path;
    return GestureDetector(
      onTap: () => setState(() => _selectedImagePath = path),
      child: Container(
        width: 100,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade300,
            width: isSelected ? 3 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
          color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(5)),
                child: path == null
                    ? const Icon(Icons.casino, size: 40, color: Colors.grey)
                    : OverflowBox(
                        maxWidth: 200,
                        maxHeight: 200,
                        child: Image.asset(
                          path,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDifficultyButton(BuildContext context, String label, int gridSize) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PuzzleBoard(
              gridSize: gridSize,
              imagePath: _getEffectiveImage(),
            ),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        textStyle: const TextStyle(fontSize: 24),
      ),
      child: Text(label),
    );
  }
}
