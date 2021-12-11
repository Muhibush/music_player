import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:music_player/core/utils/input_converter.dart';

void main() {
  late InputConverter inputConverter;

  setUpAll(() {
    inputConverter = InputConverter();
  });

  group('stringToTerm', () {
    test('should return an term from valid string', () async {
      const tListString = ['Dewa 19', 'dewa 19', 'dewa    19', ' dewa    19 '];
      const tTerm = 'dewa+19';
      for (var element in tListString) {
        final result = inputConverter.stringToTerm(element);
        expect(result, const Right(tTerm));
      }
    });
  });
  test(
    'should return a failure when term is empty',
    () async {
      const tListString = ['', ' ', '   '];
      for (var element in tListString) {
        final result = inputConverter.stringToTerm(element);
        expect(result, Left(InvalidInputFailure()));
      }
    },
  );
}
