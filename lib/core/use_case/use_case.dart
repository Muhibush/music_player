import 'package:dartz/dartz.dart';
import 'package:music_player/core/error/failure.dart';

abstract class UseCase<String, Type> {
  Future<Either<Failure, Type>> call(String term);
}
