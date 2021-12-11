import 'package:dartz/dartz.dart';
import 'package:music_player/core/error/failure.dart';
import 'package:music_player/core/use_case/use_case.dart';
import 'package:music_player/feature/music_player/domain/entities/music.dart';
import 'package:music_player/feature/music_player/domain/repositories/music_repositories.dart';

class GetListMusicUseCase extends UseCase<String, List<Music>> {
  final MusicRepository repository;

  GetListMusicUseCase(this.repository);

  @override
  Future<Either<Failure, List<Music>>> call(term) async {
    return repository.getMusic(term);
  }
}
