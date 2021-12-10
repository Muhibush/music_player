import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:music_player/core/error/exception.dart';
import 'package:music_player/feature/music_player/data/data_sources/music_remote_data_source.dart';
import 'package:music_player/feature/music_player/data/models/music_root_model.dart';

import '../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockUri extends Mock implements Uri {}

void main() {
  late MockHttpClient mockHttpClient;
  late MusicRemoteDataSource dataSource;

  setUpAll(() {
    registerFallbackValue(MockUri());
    mockHttpClient = MockHttpClient();
    dataSource = MusicRemoteDataSourceImpl(client: mockHttpClient);
  });

  tearDown(() {
    reset(mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
        .thenAnswer(
            (_) async => http.Response(fixture('music_root.json'), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('Music remote data source', () {
    const tTerm = 'dewa+19';
    final tMusicRootModel =
        MusicRootModel.fromJson(json.decode(fixture('music_root.json')));
    test(
        'should preform a GET request on a URL with number being the endpoint and with application/json header',
        () {
      setUpMockHttpClientSuccess200();

      dataSource.getMusic(tTerm);
      verify(() => mockHttpClient.get(
          Uri.parse(
              'https://itunes.apple.com/search?term=$tTerm&entity=song&limit=25&attribute=artistTerm'),
          headers: {'Content-Type': 'application/json'}));
    });
    test('should return list Music when the response code is 200 (success)',
        () async {
      setUpMockHttpClientSuccess200();

      final result = await dataSource.getMusic(tTerm);
      expect(result, tMusicRootModel.results);
    });
    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      setUpMockHttpClientFailure404();

      final callResult = dataSource.getMusic;
      expect(callResult(tTerm), throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
