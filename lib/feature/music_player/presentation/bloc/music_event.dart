part of 'music_bloc.dart';

abstract class MusicEvent extends Equatable {
  const MusicEvent();

  @override
  List<Object?> get props => [];
}

class MusicSearched extends MusicEvent {
  final String str;

  const MusicSearched(this.str);

  @override
  List<Object?> get props => [str];
}

class MusicPlayPressed extends MusicEvent {
  final Music music;

  const MusicPlayPressed(this.music);

  @override
  List<Object?> get props => [music];
}

class MusicPausePressed extends MusicEvent {}