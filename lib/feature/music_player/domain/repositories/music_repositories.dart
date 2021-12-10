import 'package:dartz/dartz.dart';
import 'package:music_player/core/error/failure.dart';
import 'package:music_player/feature/music_player/domain/entities/music.dart';

abstract class MusicRepository {
  Future<Either<Failure, Music>> getMusic(String term);
}
