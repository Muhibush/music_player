import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:music_player/feature/music_player/domain/entities/music.dart';
import 'package:music_player/feature/music_player/domain/repositories/music_repositories.dart';
import 'package:music_player/feature/music_player/domain/use_cases/get_music_use_case.dart';

class MockMusicRepository extends Mock implements MusicRepository {}

void main() {
  late GetMusicUseCase useCase;
  late MockMusicRepository repository;
  const tTerm = 'dewa+19';
  var tListMusic = [
    const Music(
        trackName: "Cinta 'Kan Membawamu Kembali",
        artistName: "Dewa 19",
        collectionName: "The Best of Dewa 19",
        artworkUrl100:
            "https://is5-ssl.mzstatic.com/image/thumb/Music125/v4/e7/58/8a/e7588af6-970c-75a8-d030-6ea46778adb6/source/100x100bb.jpg",
        previewUrl:
            "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/67/80/56/67805626-221d-8aec-07dd-a3b94e60e65e/mzaf_2602186213288694935.plus.aac.p.m4a")
  ];

  setUpAll(() {
    repository = MockMusicRepository();
    useCase = GetMusicUseCase(repository);
  });

  test('get music', () async {
    when(() => repository.getMusic(any()))
        .thenAnswer((_) async => Right(tListMusic));

    final result = await useCase(const Params(term: tTerm));

    expect(result, Right(tListMusic));
    verify(() => repository.getMusic(tTerm)).called(1);
    verifyNoMoreInteractions(repository);
  });
}
