import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:music_player/core/error/failure.dart';
import 'package:music_player/core/utils/input_converter.dart';
import 'package:music_player/feature/music_player/domain/entities/music.dart';
import 'package:music_player/feature/music_player/domain/use_cases/get_list_music_use_case.dart';

part 'music_event.dart';

part 'music_state.dart';

const String initialMessage = 'Play what you love';
const String initialSubMessage = 'Search for an artist and enjoy their songs.';
const String serverFailureMessage = 'Server Failure';
const String serverFailureSubMessage = 'Sorry we\'ll be back soon.';
const String connectionFailureMessage = 'No Connection';
const String connectionFailureSubMessage = 'Go online to search again.';

String emptyMusicMessage(String str) => 'Couldn\'t find "$str"';
const String emptyMusicSubMessage =
    'Try searching again using a different spelling or keyword.';

class MusicBloc extends Bloc<MusicEvent, MusicState> {
  final InputConverter inputConverter;
  final GetListMusicUseCase getListMusicUseCase;

  MusicBloc({
    required this.inputConverter,
    required this.getListMusicUseCase,
  }) : super(const MusicEmpty(
          listMusic: [],
          message: initialMessage,
          subMessage: initialSubMessage,
          isPlaying: false,
        )) {
    on<MusicSearched>(
      _onSearched,
      transformer: restartable(),
    );

    on<MusicPlayPressed>(
      _onPlayPressed,
      transformer: restartable(),
    );

    on<MusicPausePressed>(
      _onPausePressed,
      transformer: restartable(),
    );
  }

  void _onSearched(MusicSearched event, Emitter<MusicState> emit) async {
    final inputEither = inputConverter.stringToTerm(event.str);

    await inputEither.fold(
      (failure) async {
        /// not doing anything if input only contains whitespace
        emit(state);
      },
      (term) async {
        /// loading state
        emit(MusicLoadInProgress(
          listMusic: state.listMusic,
          playedMusic: state.playedMusic,
          isPlaying: state.isPlaying,
        ));
        final failureOrMusic = await getListMusicUseCase(term);
        failureOrMusic.fold(
          (failure) {
            /// error state
            emit(MusicEmpty(
              listMusic: state.listMusic,
              playedMusic: state.playedMusic,
              message: _mapFailureToMessage(failure),
              subMessage: _mapFailureToSubMessage(failure),
              isPlaying: state.isPlaying,
            ));
          },
          (listMusic) {
            if (listMusic.isEmpty) {
              /// empty state
              emit(MusicEmpty(
                listMusic: listMusic,
                playedMusic: state.playedMusic,
                message: emptyMusicMessage(event.str),
                subMessage: emptyMusicSubMessage,
                isPlaying: state.isPlaying,
              ));
            } else {
              /// success state
              emit(MusicLoadSuccess(
                listMusic: listMusic,
                playedMusic: state.playedMusic,
                isPlaying: state.isPlaying,
              ));
            }
          },
        );
      },
    );
  }

  void _onPlayPressed(MusicPlayPressed event, Emitter<MusicState> emit) async {
    emit(MusicPlayed(
        listMusic: state.listMusic, playedMusic: event.music, isPlaying: true));
  }

  void _onPausePressed(
      MusicPausePressed event, Emitter<MusicState> emit) async {
    emit(MusicPaused(
        listMusic: state.listMusic,
        playedMusic: state.playedMusic,
        isPlaying: false));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case ConnectionFailure:
        return connectionFailureMessage;
      default:
        return 'Unexpected Error';
    }
  }

  String _mapFailureToSubMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureSubMessage;
      case ConnectionFailure:
        return connectionFailureSubMessage;
      default:
        return 'Unexpected Error';
    }
  }
}
