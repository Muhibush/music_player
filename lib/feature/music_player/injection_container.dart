import 'package:get_it/get_it.dart';
import 'package:music_player/feature/music_player/data/data_sources/music_remote_data_source.dart';
import 'package:music_player/feature/music_player/data/repositories/music_repositories_impl.dart';
import 'package:music_player/feature/music_player/domain/repositories/music_repositories.dart';
import 'package:music_player/feature/music_player/domain/use_cases/get_list_music_use_case.dart';
import 'package:music_player/feature/music_player/presentation/bloc/music_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async{
  /// BLoc
  sl.registerFactory(() =>
      MusicBloc(
        inputConverter: sl(),
        getListMusicUseCase: sl(),
      ));

  /// Use Case
  sl.registerLazySingleton(() => GetListMusicUseCase(sl()));

  /// Repository
  sl.registerLazySingleton<MusicRepository>(() =>
      MusicRepositoryImpl(
          remoteDataSource: sl(),
          networkInfo: sl()
      ));

  /// Data Source
  sl.registerLazySingleton<MusicRemoteDataSource>(() =>
      MusicRemoteDataSourceImpl(client: sl()));
}
