import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:music_player/core/error/exception.dart';
import 'package:music_player/feature/music_player/data/models/music_root_model.dart';

abstract class MusicRemoteDataSource {
  Future<List<MusicModel>> getMusic(String term);
}

class MusicRemoteDataSourceImpl extends MusicRemoteDataSource {
  final http.Client client;

  MusicRemoteDataSourceImpl({required this.client});

  @override
  Future<List<MusicModel>> getMusic(String term) async {
    final response = await client.get(
        Uri.parse(
            'https://itunes.apple.com/search?term=$term&entity=song&limit=25&attribute=artistTerm'),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      final root = MusicRootModel.fromJson(json.decode(response.body));
      return root.results ?? [];
    } else {
      throw ServerException();
    }
  }
}
