part of 'music_bloc.dart';

abstract class MusicState extends Equatable {
  final List<Music> listMusic;
  final Music? playedMusic;

  const MusicState({required this.listMusic, this.playedMusic});

  @override
  List<Object?> get props => [listMusic, playedMusic];

  @override
  String toString() {
    return runtimeType.toString() +
        "\ntrackName: " +
        (playedMusic?.trackName ?? 'empty') +
        "\nlistMusicLength: " +
        (listMusic.length.toString());
  }
}

class MusicLoadInProgress extends MusicState {
  const MusicLoadInProgress(
      {required List<Music> listMusic, Music? playedMusic})
      : super(listMusic: listMusic, playedMusic: playedMusic);
}

class MusicLoadSuccess extends MusicState {
  const MusicLoadSuccess({required List<Music> listMusic, Music? playedMusic})
      : super(listMusic: listMusic, playedMusic: playedMusic);
}

class MusicEmpty extends MusicState {
  final String message;
  final String subMessage;

  const MusicEmpty(
      {required List<Music> listMusic,
      Music? playedMusic,
      required this.message,
      required this.subMessage})
      : super(listMusic: listMusic, playedMusic: playedMusic);

  @override
  List<Object?> get props => [listMusic, message, subMessage];
}

class MusicPlayed extends MusicState {
  const MusicPlayed({required List<Music> listMusic, Music? playedMusic})
      : super(listMusic: listMusic, playedMusic: playedMusic);
}

class MusicPaused extends MusicState {
  const MusicPaused({required List<Music> listMusic, Music? playedMusic})
      : super(listMusic: listMusic, playedMusic: playedMusic);
}
