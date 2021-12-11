import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:music_player/core/network/network_info.dart';

class MockInternetConnectionChecker extends Mock
    implements InternetConnectionChecker {}

void main() {
  late NetworkInfoImpl networkInfo;
  late MockInternetConnectionChecker mockInternetConnectionChecker;

  setUpAll(() {
    mockInternetConnectionChecker = MockInternetConnectionChecker();
    networkInfo = NetworkInfoImpl(mockInternetConnectionChecker);
  });

  tearDown(() {
    reset(mockInternetConnectionChecker);
  });

  group('isConnected', () {
    test(
        'should forward the call to InternetConnectionChecker.hasConnection true',
        () async {
      const tHasConnectionFuture = true;

      when(() => mockInternetConnectionChecker.hasConnection)
          .thenAnswer((_) async => tHasConnectionFuture);

      final result = await networkInfo.isConnected;

      verify(() => mockInternetConnectionChecker.hasConnection).called(1);
      expect(result, tHasConnectionFuture);
    });
  });

  group('isNotConnected', () {
    test(
        'should forward the call to InternetConnectionChecker.hasConnection false',
        () async {
      const tHasConnectionFuture = false;

      when(() => mockInternetConnectionChecker.hasConnection)
          .thenAnswer((_) async => tHasConnectionFuture);

      final result = await networkInfo.isConnected;

      verify(() => mockInternetConnectionChecker.hasConnection).called(1);
      expect(result, tHasConnectionFuture);
    });
  });
}
