part of 'music_bloc.dart';

abstract class MusicState extends Equatable {
  final List<Music> listMusic;
  final Music? playedMusic;
  final bool isPlaying;

  const MusicState(
      {required this.listMusic, this.playedMusic, required this.isPlaying});

  @override
  List<Object?> get props => [listMusic, playedMusic, isPlaying];

  @override
  String toString() {
    return "\n----------\n" +
        runtimeType.toString() +
        "\ntrackName: " +
        (playedMusic?.trackName ?? 'empty') +
        "\nlistMusicLength: " +
        (listMusic.length.toString() + "\n");
  }
}

class MusicLoadInProgress extends MusicState {
  const MusicLoadInProgress({
    required List<Music> listMusic,
    Music? playedMusic,
    required bool isPlaying,
  }) : super(
            listMusic: listMusic,
            playedMusic: playedMusic,
            isPlaying: isPlaying);
}

class MusicLoadSuccess extends MusicState {
  const MusicLoadSuccess({
    required List<Music> listMusic,
    Music? playedMusic,
    required bool isPlaying,
  }) : super(
            listMusic: listMusic,
            playedMusic: playedMusic,
            isPlaying: isPlaying);
}

class MusicEmpty extends MusicState {
  final String message;
  final String subMessage;

  const MusicEmpty({
    required List<Music> listMusic,
    Music? playedMusic,
    required this.message,
    required this.subMessage,
    required bool isPlaying,
  }) : super(
            listMusic: listMusic,
            playedMusic: playedMusic,
            isPlaying: isPlaying);

  @override
  List<Object?> get props => [listMusic, message, subMessage];
}

class MusicPlayed extends MusicState {
  const MusicPlayed({
    required List<Music> listMusic,
    Music? playedMusic,
    required bool isPlaying,
  }) : super(
            listMusic: listMusic,
            playedMusic: playedMusic,
            isPlaying: isPlaying);
}

class MusicPaused extends MusicState {
  const MusicPaused({
    required List<Music> listMusic,
    Music? playedMusic,
    required bool isPlaying,
  }) : super(
            listMusic: listMusic,
            playedMusic: playedMusic,
            isPlaying: isPlaying);
}
