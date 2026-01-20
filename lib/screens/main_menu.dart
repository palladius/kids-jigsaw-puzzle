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
    'assets/images/ale-seby-piramide-uxmal.png',
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

  @override
  void initState() {
    super.initState();
    // Select a random image by default on startup
    _selectRandomImage();
  }

  void _selectRandomImage() {
    setState(() {
      _selectedImagePath = _images[Random().nextInt(_images.length)];
    });
  }

  String _getEffectiveImage() {
    return _selectedImagePath ?? _images[Random().nextInt(_images.length)];
  }

  void _showImageSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => ImageSelectionDialog(
        images: _images,
        onImageSelected: (path) {
          setState(() {
            _selectedImagePath = path;
          });
          Navigator.pop(context);
        },
      ),
    );
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

              // --- New Image Selector ---
              Text(
                'Selected Image (${_images.length} available):',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 15),

              // Currently Selected Image Preview
              if (_selectedImagePath != null)
                Container(
                  width: 200,
                  height: 200,
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
                      _selectedImagePath!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              if (_selectedImagePath != null)
                 Padding(
                   padding: const EdgeInsets.only(top: 8.0),
                   child: Text(
                     _selectedImagePath!.split('/').last.split('.').first,
                     style: const TextStyle(fontWeight: FontWeight.bold),
                   ),
                 ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Random Button
                  ElevatedButton.icon(
                    onPressed: _selectRandomImage,
                    icon: const Icon(Icons.casino),
                    label: const Text('Random'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    ),
                  ),
                  const SizedBox(width: 20),
                  // Choose Button
                  ElevatedButton.icon(
                    onPressed: () => _showImageSelectionDialog(context),
                    icon: const Icon(Icons.photo_library),
                    label: const Text('Choose Image'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    ),
                  ),
                ],
              ),
              // --------------------------

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

class ImageSelectionDialog extends StatefulWidget {
  final List<String> images;
  final Function(String) onImageSelected;

  const ImageSelectionDialog({
    super.key,
    required this.images,
    required this.onImageSelected,
  });

  @override
  State<ImageSelectionDialog> createState() => _ImageSelectionDialogState();
}

class _ImageSelectionDialogState extends State<ImageSelectionDialog> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filteredImages = widget.images.where((path) {
      final name = path.split('/').last.split('.').first;
      return name.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 800, // Fixed width for desktop/web
        height: 600,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Header
            Row(
              children: [
                const Icon(Icons.image, size: 28),
                const SizedBox(width: 10),
                const Text(
                  'Choose an Image',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Search images...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
              ),
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
            const SizedBox(height: 20),

            // Image Grid
            Expanded(
              child: filteredImages.isEmpty
                  ? const Center(
                      child: Text('No images found',
                          style: TextStyle(fontSize: 18, color: Colors.grey)),
                    )
                  : GridView.builder(
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 150,
                        childAspectRatio: 1,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: filteredImages.length,
                      itemBuilder: (context, index) {
                        final path = filteredImages[index];
                        final name = path.split('/').last.split('.').first;
                        return InkWell(
                          onTap: () => widget.onImageSelected(path),
                          borderRadius: BorderRadius.circular(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    path,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(
                                  name,
                                  style: const TextStyle(fontSize: 12),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
