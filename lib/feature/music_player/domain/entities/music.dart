import 'package:equatable/equatable.dart';

class Music extends Equatable {
  final String trackName;
  final String artistName;
  final String collectionName;
  final String? artworkUrl100;
  final String? previewUrl;

  const Music({
    required this.trackName,
    required this.artistName,
    required this.collectionName,
    this.artworkUrl100,
    this.previewUrl,
  });

  @override
  List<Object?> get props =>
      [trackName, artistName, collectionName, artworkUrl100, previewUrl];
}
