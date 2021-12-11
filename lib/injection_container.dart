import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:music_player/core/network/network_info.dart';
import 'package:music_player/feature/music_player/injection_container.dart'
    as music_player_di;

final sl = GetIt.instance;

Future<void> init() async {
  /// Features
  await music_player_di.init();

  /// Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  /// External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
