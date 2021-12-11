part of 'music_bloc.dart';

abstract class MusicState extends Equatable {
  final List<Music> listMusic;

  const MusicState(this.listMusic);

  @override
  List<Object?> get props => [listMusic];

  @override
  String toString() {
    return runtimeType.toString();
  }
}

class MusicLoadInProgress extends MusicState {
  const MusicLoadInProgress(List<Music> listMusic) : super(listMusic);
}

class MusicLoadSuccess extends MusicState {
  const MusicLoadSuccess(List<Music> listMusic) : super(listMusic);
}

class MusicEmpty extends MusicState {
  final String message;

  const MusicEmpty(List<Music> listMusic, this.message) : super(listMusic);

  @override
  List<Object?> get props => [listMusic, message];
}

class MusicPlayed extends MusicState {
  const MusicPlayed(List<Music> listMusic) : super(listMusic);
}

class MusicPaused extends MusicState {
  const MusicPaused(List<Music> listMusic) : super(listMusic);
}

class MusicResumed extends MusicState {
  const MusicResumed(List<Music> listMusic) : super(listMusic);
}
