import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:music_player/feature/music_player/data/models/music_root_model.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  const tMusic1 = MusicModel(
    trackName: "Cinta 'Kan Membawamu Kembali",
    artistName: "Dewa 19",
    collectionName: "The Best of Dewa 19",
    artworkUrl100:
        "https://is5-ssl.mzstatic.com/image/thumb/Music125/v4/e7/58/8a/e7588af6-970c-75a8-d030-6ea46778adb6/source/100x100bb.jpg",
    previewUrl:
        "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/67/80/56/67805626-221d-8aec-07dd-a3b94e60e65e/mzaf_2602186213288694935.plus.aac.p.m4a",
  );
  const tMusic2 = MusicModel(
    trackName: "Kamulah Satu Satunya",
    artistName: "Dewa 19",
    collectionName: "The Best of Dewa 19",
  );
  var tMusicRoot =
      const MusicRootModel(resultCount: 2, results: [tMusic1, tMusic2]);

  group('Music root model', () {
    test('fromJson', () async {
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('music_root.json'));
      final result = MusicRootModel.fromJson(jsonMap);
      expect(result, tMusicRoot);
    });

    test('toJson', () async {
      final result = tMusicRoot.toJson();
      expect(result['resultCount'], 2);
      expect(result['results'][0], tMusic1);
      expect(result['results'][1], tMusic2);
    });
  });

  group('Music model', () {
    test('fromJson with artworkUrl100 and previewUrl', () async {
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('music_with_artwork_and_preview.json'));
      final result = MusicModel.fromJson(jsonMap);
      expect(result, tMusic1);
    });

    test('fromJson without artworkUrl100 and previewUrl', () async {
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('music_without_artwork_and_preview.json'));
      final result = MusicModel.fromJson(jsonMap);
      expect(result, tMusic2);
    });

    test('toJson with artworkUrl100 and previewUrl', () async {
      final result = tMusic1.toJson();
      final expectedJsonMap = {
        "artistName": "Dewa 19",
        "collectionName": "The Best of Dewa 19",
        "trackName": "Cinta 'Kan Membawamu Kembali",
        "previewUrl":
            "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/67/80/56/67805626-221d-8aec-07dd-a3b94e60e65e/mzaf_2602186213288694935.plus.aac.p.m4a",
        "artworkUrl100":
            "https://is5-ssl.mzstatic.com/image/thumb/Music125/v4/e7/58/8a/e7588af6-970c-75a8-d030-6ea46778adb6/source/100x100bb.jpg",
      };
      expect(result, expectedJsonMap);
    });

    test('toJson without artworkUrl100 and previewUrl', () async {
      final result = tMusic2.toJson();
      final expectedJsonMap = {
        "artistName": "Dewa 19",
        "collectionName": "The Best of Dewa 19",
        "trackName": "Kamulah Satu Satunya",
        "previewUrl": null,
        "artworkUrl100": null,
      };
      expect(result, expectedJsonMap);
    });
  });
}
