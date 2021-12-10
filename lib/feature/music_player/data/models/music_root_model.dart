import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:music_player/feature/music_player/domain/entities/music.dart';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class MusicRootModel extends Equatable {
  const MusicRootModel({
    this.resultCount,
    this.results,
  });

  factory MusicRootModel.fromJson(Map<String, dynamic> jsonRes) {
    final List<MusicModel>? results =
        jsonRes['results'] is List ? <MusicModel>[] : null;
    if (results != null) {
      for (final dynamic item in jsonRes['results']!) {
        if (item != null) {
          results.add(MusicModel.fromJson(asT<Map<String, dynamic>>(item)!));
        }
      }
    }
    return MusicRootModel(
      resultCount: asT<int?>(jsonRes['resultCount']),
      results: results,
    );
  }

  final int? resultCount;
  final List<MusicModel>? results;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'resultCount': resultCount,
        'results': results,
      };

  @override
  List<Object?> get props => [resultCount, results];
}

class MusicModel extends Music {
  const MusicModel({
    required String artistName,
    required String collectionName,
    required String trackName,
    String? previewUrl,
    String? artworkUrl100,
  }) : super(
            artistName: artistName,
            collectionName: collectionName,
            trackName: trackName,
            previewUrl: previewUrl,
            artworkUrl100: artworkUrl100);

  factory MusicModel.fromJson(Map<String, dynamic> jsonRes) => MusicModel(
        artistName: jsonRes['artistName'],
        collectionName: jsonRes['collectionName'],
        trackName: jsonRes['trackName'],
        previewUrl: asT<String?>(jsonRes['previewUrl']),
        artworkUrl100: asT<String?>(jsonRes['artworkUrl100']),
      );

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'artistName': artistName,
        'collectionName': collectionName,
        'trackName': trackName,
        'previewUrl': previewUrl,
        'artworkUrl100': artworkUrl100,
      };
}
