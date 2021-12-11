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

class MusicPlayPressed extends MusicEvent {}

class MusicPausePressed extends MusicEvent {}

class MusicResumePressed extends MusicEvent {}
