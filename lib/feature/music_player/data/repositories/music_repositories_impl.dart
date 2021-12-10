import 'package:dartz/dartz.dart';
import 'package:music_player/core/error/exception.dart';
import 'package:music_player/core/error/failure.dart';
import 'package:music_player/core/network/network_info.dart';
import 'package:music_player/feature/music_player/data/data_sources/music_remote_data_source.dart';
import 'package:music_player/feature/music_player/domain/entities/music.dart';
import 'package:music_player/feature/music_player/domain/repositories/music_repositories.dart';

class MusicRepositoryImpl implements MusicRepository {
  final MusicRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  MusicRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Music>>> getMusic(String term) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getMusic(term);
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
}
