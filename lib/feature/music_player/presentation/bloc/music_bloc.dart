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
const String serverFailureMessage = 'Server Failure';
const String connectionFailureMessage = 'No Connection';

String emptyMusicMessage(String str) => 'Couldn\'t find "$str"';

class MusicBloc extends Bloc<MusicEvent, MusicState> {
  final InputConverter inputConverter;
  final GetListMusicUseCase getListMusicUseCase;

  MusicBloc({
    required this.inputConverter,
    required this.getListMusicUseCase,
  }) : super(const MusicEmpty([], initialMessage)) {
    on<MusicSearched>(
      _onSearched,
      transformer: droppable(),
    );
  }

  /// TODO handle debounce
  void _onSearched(MusicSearched event, Emitter<MusicState> emit) async {
    final inputEither = inputConverter.stringToTerm(event.str);

    await inputEither.fold(
      /// not doing anything if input only contains whitespace
      (failure) async => emit(state),
      (term) async {
        /// loading state
        emit(MusicLoadInProgress(state.listMusic));
        final failureOrMusic = await getListMusicUseCase(term);
        await failureOrMusic.fold(
          /// error state
          (failure) async =>
              emit(MusicEmpty(state.listMusic, _mapFailureToMessage(failure))),
          (listMusic) async {
            if (listMusic.isEmpty) {
              /// empty state
              emit(MusicEmpty(listMusic, emptyMusicMessage(event.str)));
            } else {
              /// success state
              emit(MusicLoadSuccess(listMusic));
            }
          },
        );
      },
    );
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
}
