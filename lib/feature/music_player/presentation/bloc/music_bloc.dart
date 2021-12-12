import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:music_player/core/error/failure.dart';
import 'package:music_player/core/utils/input_converter.dart';
import 'package:music_player/feature/music_player/domain/entities/music.dart';
import 'package:music_player/feature/music_player/domain/use_cases/get_list_music_use_case.dart';

part 'music_event.dart';

part 'music_state.dart';

const String initialMessage = 'Search your favorite artist';
const String initialSubMessage =
    'Try searching again using a different spelling or keyword.';
const String serverFailureMessage = 'Server Failure';
const String serverFailureSubMessage = 'Sorry we\'ll be back soon.';
const String connectionFailureMessage = 'No Connection';
const String connectionFailureSubMessage = 'Go online to search again.';

String emptyMusicMessage(String str) => 'Couldn\'t find "$str"';

class MusicBloc extends Bloc<MusicEvent, MusicState> {
  final InputConverter inputConverter;
  final GetListMusicUseCase getListMusicUseCase;

  MusicBloc({
    required this.inputConverter,
    required this.getListMusicUseCase,
  }) : super(const MusicEmpty(
            listMusic: [],
            message: initialMessage,
            subMessage: initialSubMessage)) {
    on<MusicSearched>(
      _onSearched,
      transformer: droppable(),
    );

    on<MusicPlayPressed>(
      _onPlayPressed,
      transformer: droppable(),
    );

    on<MusicPausePressed>(
      _onPausePressed,
      transformer: droppable(),
    );
  }

  void _onSearched(MusicSearched event, Emitter<MusicState> emit) async {
    final inputEither = inputConverter.stringToTerm(event.str);

    await inputEither.fold(
      /// not doing anything if input only contains whitespace
      (failure) async => emit(state),
      (term) async {
        /// loading state
        emit(MusicLoadInProgress(
            listMusic: state.listMusic, playedMusic: state.playedMusic));
        final failureOrMusic = await getListMusicUseCase(term);
        await failureOrMusic.fold(
          /// error state
          (failure) async => emit(MusicEmpty(
            listMusic: state.listMusic,
            playedMusic: state.playedMusic,
            message: _mapFailureToMessage(failure),
            subMessage: _mapFailureToSubMessage(failure),
          )),
          (listMusic) async {
            if (listMusic.isEmpty) {
              /// empty state
              emit(MusicEmpty(
                listMusic: listMusic,
                playedMusic: state.playedMusic,
                message: emptyMusicMessage(event.str),
                subMessage: initialSubMessage,
              ));
            } else {
              /// success state
              emit(MusicLoadSuccess(
                listMusic: listMusic,
                playedMusic: state.playedMusic,
              ));
            }
          },
        );
      },
    );
  }

  void _onPlayPressed(MusicPlayPressed event, Emitter<MusicState> emit) async {
    emit(MusicPlayed(listMusic: state.listMusic, playedMusic: event.music));
  }

  void _onPausePressed(
      MusicPausePressed event, Emitter<MusicState> emit) async {
    emit(MusicPaused(
        listMusic: state.listMusic, playedMusic: state.playedMusic));
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
