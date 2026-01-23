import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'puzzle_board.dart';
import 'leaderboard_screen.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  List<String> _images = [];
  bool _isLoadingImages = true;
  String? _selectedImagePath; // null means random

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  Future<void> _loadImages() async {
    try {
      // Use the AssetManifest API for robust asset listing
      final manifest = await AssetManifest.loadFromAssetBundle(rootBundle);
      
      final imagePaths = manifest.listAssets()
          .where((String key) => key.startsWith('assets/images/') && 
                (key.endsWith('.png') || key.endsWith('.jpg') || key.endsWith('.jpeg')))
          .toList();
      
      // Sort alphabetically for consistency
      imagePaths.sort();

      if (mounted) {
        setState(() {
          _images = imagePaths;
          _isLoadingImages = false;
          _selectRandomImage();
        });
      }
    } catch (e) {
      debugPrint('Error loading asset manifest: $e');
      if (mounted) {
        setState(() {
          _isLoadingImages = false;
          // Fallback if manifest fails
          _images = ['assets/images/logo.png']; 
        });
      }
    }
  }

  void _selectRandomImage() {
    if (_images.isEmpty) return;
    setState(() {
      _selectedImagePath = _images[Random().nextInt(_images.length)];
    });
  }

  String _getEffectiveImage() {
    if (_images.isEmpty) return 'assets/images/logo.png';
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
        title: RichText(
          text: const TextSpan(
            style: TextStyle(fontSize: 20, color: Colors.white),
            children: [
              TextSpan(text: 'Kids Jigsaw Puzzle ', style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: 'v1.1.13', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16)),
            ],
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 900;

          if (isWide) {
            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                child: Column(
                  children: [
                    const Text(
                      'Welcome!',
                      style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left Column: Image Selection
                        SizedBox(
                          width: 400,
                          child: Column(
                            children: [
                              Text(
                                'Selected Image (${_images.length} available):',
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 20),
                              _buildImagePreview(),
                              const SizedBox(height: 20),
                              _buildImageSelectionButtons(context),
                              const SizedBox(height: 40),
                              _buildHallOfFameButton(context),
                            ],
                          ),
                        ),
                        const SizedBox(width: 60),
                        // Right Column: Difficulty
                        SizedBox(
                          width: 320,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Choose Difficulty:',
                                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 20),
                              if (isDebug) _buildDifficultyButton(context, 'DEBUG (2x2)', 2, Colors.red.shade100),
                              _buildDifficultyButton(context, 'Easy Peasy (4x4)', 4, Colors.green.shade100),
                              _buildDifficultyButton(context, 'Lemon Squeezy (5x5)', 5, Colors.lime.shade100),
                              _buildDifficultyButton(context, 'Smarty Pants (6x6)', 6, Colors.blue.shade100),
                              _buildDifficultyButton(context, 'Whiz Kid (7x7)', 7, Colors.orange.shade100),
                              _buildDifficultyButton(context, 'Genius Mode (8x8)', 8, Colors.purple.shade100),
                              _buildDifficultyButton(context, 'Airport Wait (10x10)', 10, Colors.grey.shade200),
                              _buildDifficultyButton(context, 'Netflix is Down (12x12)', 12, Colors.red.shade50),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Welcome!',
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Selected Image (${_images.length} available):',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 20),
                    _buildImagePreview(),
                    const SizedBox(height: 20),
                    _buildImageSelectionButtons(context),
                    const SizedBox(height: 40),
                    const Text(
                      'Choose Difficulty:',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    if (isDebug) _buildDifficultyButton(context, 'DEBUG (2x2)', 2, Colors.red.shade100),
                    _buildDifficultyButton(context, 'Easy Peasy (4x4)', 4, Colors.green.shade100),
                    _buildDifficultyButton(context, 'Lemon Squeezy (5x5)', 5, Colors.lime.shade100),
                    _buildDifficultyButton(context, 'Smarty Pants (6x6)', 6, Colors.blue.shade100),
                    _buildDifficultyButton(context, 'Whiz Kid (7x7)', 7, Colors.orange.shade100),
                    _buildDifficultyButton(context, 'Genius Mode (8x8)', 8, Colors.purple.shade100),
                    _buildDifficultyButton(context, 'Airport Wait (10x10)', 10, Colors.grey.shade200),
                    _buildDifficultyButton(context, 'Netflix is Down (12x12)', 12, Colors.red.shade50),
                    const SizedBox(height: 40),
                    _buildHallOfFameButton(context),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildImagePreview() {
    final imagePath = _selectedImagePath ?? 'assets/images/logo.png'; // Fallback for preview
    return Column(
      children: [
        Container(
          width: 250,
          height: 250,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue, width: 4),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: _selectedImagePath == null 
              ? const Center(child: Icon(Icons.casino, size: 80, color: Colors.blue))
              : Image.asset(imagePath, fit: BoxFit.cover),
          ),
        ),
        if (_selectedImagePath != null)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(
              _selectedImagePath!.split('/').last.split('.').first,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          )
        else
          const Padding(
            padding: EdgeInsets.only(top: 12),
            child: Text('Random Image', style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic)),
          ),
      ],
    );
  }

  Widget _buildImageSelectionButtons(BuildContext context) {
    return Wrap(
      spacing: 15,
      runSpacing: 10,
      alignment: WrapAlignment.center,
      children: [
        ElevatedButton.icon(
          onPressed: () => setState(() => _selectedImagePath = null),
          icon: const Icon(Icons.casino),
          label: const Text('Random'),
          style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15)),
        ),
        ElevatedButton.icon(
          onPressed: () => _showImageSelectionDialog(context),
          icon: const Icon(Icons.photo_library),
          label: const Text('Choose Image'),
          style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15)),
        ),
      ],
    );
  }

  Widget _buildHallOfFameButton(BuildContext context) {
    return ElevatedButton.icon(
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
    );
  }

  Widget _buildDifficultyButton(BuildContext context, String label, int gridSize, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: SizedBox(
        width: 280,
        child: ElevatedButton(
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
            backgroundColor: color,
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 20),
            textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: Text(label),
        ),
      ),
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
              autofocus: true,
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
