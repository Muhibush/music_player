import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:music_player/core/error/exception.dart';
import 'package:music_player/core/error/failure.dart';
import 'package:music_player/core/network/network_info.dart';
import 'package:music_player/feature/music_player/data/data_sources/music_remote_data_source.dart';
import 'package:music_player/feature/music_player/data/models/music_root_model.dart';
import 'package:music_player/feature/music_player/data/repositories/music_repositories_impl.dart';

import '../../../fixtures/fixture_reader.dart';

class MockMusicRemoteDataSource extends Mock implements MusicRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late MockMusicRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late MusicRepositoryImpl repositoryImpl;

  setUpAll(() {
    mockRemoteDataSource = MockMusicRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repositoryImpl = MusicRepositoryImpl(
        remoteDataSource: mockRemoteDataSource, networkInfo: mockNetworkInfo);
  });

  tearDown(() {
    reset(mockRemoteDataSource);
  });

  void runTestOnline(Function body) {
    group('device is online', () {
      setUpAll(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestOffline(Function body) {
    group('device is offline', () {
      setUpAll(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('getMusic', () {
    const tTerm = 'dewa+19';
    final tMusicRootModel =
        MusicRootModel.fromJson(json.decode(fixture('music_root.json')));

    runTestOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          when(() => mockRemoteDataSource.getMusic(tTerm))
              .thenAnswer((_) async => Future.value(tMusicRootModel.results));

          final result = await repositoryImpl.getMusic(tTerm);

          verify(() => mockRemoteDataSource.getMusic(tTerm)).called(1);
          expect(result, Right(tMusicRootModel.results));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          when(() => mockRemoteDataSource.getMusic(tTerm))
              .thenThrow(ServerException());

          final result = await repositoryImpl.getMusic(tTerm);

          verify(() => mockRemoteDataSource.getMusic(tTerm)).called(1);
          expect(result, Left(ServerFailure()));
        },
      );
    });

    runTestOffline(() {
      test(
        'should return ConnectionFailure when device is offline',
        () async {
          final result = await repositoryImpl.getMusic(tTerm);

          verifyZeroInteractions(mockRemoteDataSource);

          expect(result, Left(ConnectionFailure()));
        },
      );
    });
  });
}
