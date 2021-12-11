import 'package:dartz/dartz.dart';
import 'package:music_player/core/error/failure.dart';

class InputConverter {
  Either<Failure, String> stringToTerm(String str) {
    try {
      final result = str.trim().replaceAll(RegExp(' +'), '+').toLowerCase();
      if (result.isEmpty) throw const FormatException();
      return Right(result);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {}
