import 'dart:async';
import 'dart:convert';
import 'dart:io';

/// Native (Linux, macOS, Android, iOS, VM test) platform bridge for PuffinLogin.
class PuffinPlatformBridge {
  static String? getRawStorageItem(String key) => null;

  static void setRawStorageItem(String key, String value) {}

  static void removeRawStorageItem(String key) {}

  static void listenToWebEvents({
    required void Function() onAuthOrScoreChanged,
  }) {}

  static bool openWebModal([String? preselectUserId]) => false;

  static void setWebHallOfFameVisible(bool visible) {}

  static String getHostname() {
    try {
      return Platform.localHostname;
    } catch (_) {
      return '';
    }
  }

  static String getDeviceLabel() {
    try {
      return '${Platform.operatingSystem} (${Platform.operatingSystemVersion.split(' ').first})';
    } catch (_) {
      return 'Flutter Native';
    }
  }

  static bool get _isTestEnvironment {
    try {
      return Platform.environment.containsKey('FLUTTER_TEST') ||
          HttpOverrides.current != null;
    } catch (_) {
      return true;
    }
  }

  static Future<String?> httpGet(String url) async {
    if (_isTestEnvironment) return null;
    final client = HttpClient()..connectionTimeout = const Duration(milliseconds: 2200);
    try {
      final req = await client.getUrl(Uri.parse(url)).timeout(const Duration(milliseconds: 2500));
      final res = await req.close().timeout(const Duration(milliseconds: 2500));
      if (res.statusCode >= 200 && res.statusCode < 300) {
        return await res.transform(utf8.decoder).join();
      }
    } catch (_) {
      // Offline / Airplane mode fallback
    } finally {
      client.close(force: true);
    }
    return null;
  }

  static Future<String?> httpPostJson(String url, Map<String, dynamic> body) async {
    if (_isTestEnvironment) return null;
    final client = HttpClient()..connectionTimeout = const Duration(milliseconds: 2200);
    try {
      final req = await client.postUrl(Uri.parse(url)).timeout(const Duration(milliseconds: 2500));
      req.headers.contentType = ContentType.json;
      req.add(utf8.encode(jsonEncode(body)));
      final res = await req.close().timeout(const Duration(milliseconds: 2500));
      if (res.statusCode >= 200 && res.statusCode < 300) {
        return await res.transform(utf8.decoder).join();
      }
    } catch (_) {
      // Offline / Airplane mode fallback
    } finally {
      client.close(force: true);
    }
    return null;
  }
}
