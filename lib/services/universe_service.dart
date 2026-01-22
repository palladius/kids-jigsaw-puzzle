import 'package:flutter/services.dart';

class UniverseService {
  static const String _assetPathPrefix = 'assets/images/universes/';

  // Returns a map of universe name -> list of image paths
  Future<Map<String, List<String>>> getUniverses() async {
    final Map<String, List<String>> universes = {};
    
    try {
      // Use the new AssetManifest API (Flutter 3.19+) that handles both .json and .bin
      final AssetManifest assetManifest = await AssetManifest.loadFromAssetBundle(rootBundle);
      final List<String> assets = assetManifest.listAssets();
      
      print('DEBUG: UniverseService found ${assets.length} total assets via AssetManifest API.');

      for (final String key in assets) {
        if (!key.contains('universes/')) continue;
        
        // Robust extraction: find 'universes/' and take what follows
        final parts = key.split('universes/');
        if (parts.length < 2) continue;
        
        final relativePath = parts[1]; // e.g., "default/logo.png" or "riccardo-family/foo.png"
        final subParts = relativePath.split('/');
        
        if (subParts.length >= 2) {
          final universeName = subParts[0];
          universes.putIfAbsent(universeName, () => []);
          universes[universeName]!.add(key);
        }
      }
      
      print('DEBUG: Universe keys found: ${universes.keys.toList()}');

    } catch (e) {
      print('DEBUG: Error loading AssetManifest: $e');
      // Fallback for tests or errors
      return {'default': ['assets/images/universes/default/logo.png']};
    }
    
    return universes;
  }
}
