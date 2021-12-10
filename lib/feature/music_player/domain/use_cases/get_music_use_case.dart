import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:music_player/core/error/failure.dart';
import 'package:music_player/core/use_case/use_case.dart';
import 'package:music_player/feature/music_player/domain/entities/music.dart';
import 'package:music_player/feature/music_player/domain/repositories/music_repositories.dart';

class GetMusicUseCase extends UseCase<Params, List<Music>> {
  final MusicRepository repository;

  GetMusicUseCase(this.repository);

  @override
  Future<Either<Failure, List<Music>>> call(params) async {
    return repository.getMusic(params.term);
  }
}

class Params extends Equatable {
  final String term;

  const Params({required this.term});

  @override
  List<Object?> get props => [term];
}
