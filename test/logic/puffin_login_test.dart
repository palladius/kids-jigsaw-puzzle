import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kids_jigsaw_puzzle/logic/puffin_login.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    PuffinLogin.instance.resetLockout();
  });

  group('PuffinLogin Core & Security Invariants', () {
    test('Canonical 6 family profiles match spec colors and auth types', () {
      expect(kPuffinProfiles.length, 6);
      expect(getPuffinProfileById('riccardo').colorHex, '#FACC15');
      expect(getPuffinProfileById('kate').colorHex, '#A855F7');
      expect(getPuffinProfileById('ale').colorHex, '#EF4444');
      expect(getPuffinProfileById('seby').colorHex, '#3B82F6');
      expect(getPuffinProfileById('lucilla').colorHex, '#EC4899');
      expect(getPuffinProfileById('guest').colorHex, '#9CA3AF');

      expect(getPuffinProfileById('ale').authType, 'pin4');
      expect(getPuffinProfileById('seby').authType, 'pin4');
      expect(getPuffinProfileById('guest').authType, 'none');
    });

    test('Aliases normalize to canonical profile IDs', () {
      expect(normalizePuffinProfileId('alessandro'), 'ale');
      expect(normalizePuffinProfileId('sebi'), 'seby');
      expect(normalizePuffinProfileId('papino'), 'riccardo');
      expect(normalizePuffinProfileId('mamma'), 'kate');
      expect(normalizePuffinProfileId('nonna'), 'lucilla');
      expect(normalizePuffinProfileId('ospite'), 'guest');
      expect(normalizePuffinProfileId(null, allowNull: true), isNull);
    });

    test('Salted SHA-256 verification matches canonical hashes for PINs', () {
      final ale = getPuffinProfileById('ale');
      final seby = getPuffinProfileById('seby');
      expect(PuffinLogin.instance.verifyCredential(ale, '2018'), isTrue);
      expect(PuffinLogin.instance.verifyCredential(ale, '0000'), isFalse);
      expect(PuffinLogin.instance.verifyCredential(seby, '2020'), isTrue);
      expect(PuffinLogin.instance.verifyCredential(seby, '9999'), isFalse);
    });

    test('3-strike lockout jams after 3 failed attempts and resets on unjam', () {
      expect(PuffinLogin.instance.getLockoutStatus('ale').jammed, isFalse);
      PuffinLogin.instance.recordFailedAttempt('ale');
      PuffinLogin.instance.recordFailedAttempt('ale');
      expect(PuffinLogin.instance.getLockoutStatus('ale').jammed, isFalse);

      final third = PuffinLogin.instance.recordFailedAttempt('ale');
      expect(third.jammed, isTrue);
      expect(third.remainingSec, greaterThan(0));

      PuffinLogin.instance.resetLockout('ale');
      expect(PuffinLogin.instance.getLockoutStatus('ale').jammed, isFalse);
    });

    test('submitScore persists guaranteed root fields and extra leaves', () async {
      await PuffinLogin.instance.loginAs('ale');
      final rec = await PuffinLogin.instance.submitScore(
        score: 9500,
        durationSec: 42,
        extra: <String, dynamic>{
          'difficulty': '4x4',
          'grid_size': 4,
          'pieces': 16,
          'schema_hash': 'jigsaw_ale-pupurabbu_4x4',
        },
      );

      expect(rec.gameId, 'kids-jigsaw-puzzle');
      expect(rec.playerId, 'ale');
      expect(rec.score, 9500);
      expect(rec.durationSec, 42);
      expect(rec.extra['schema_hash'], 'jigsaw_ale-pupurabbu_4x4');

      final lb = PuffinLogin.instance.getLeaderboard(gameId: 'kids-jigsaw-puzzle');
      expect(lb.first.score, 9500);
      expect(lb.first.playerId, 'ale');
    });
  });
}
