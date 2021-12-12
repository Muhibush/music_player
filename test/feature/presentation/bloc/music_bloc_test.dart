import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:music_player/core/error/failure.dart';
import 'package:music_player/core/utils/input_converter.dart';
import 'package:music_player/feature/music_player/data/models/music_root_model.dart';
import 'package:music_player/feature/music_player/domain/use_cases/get_list_music_use_case.dart';
import 'package:music_player/feature/music_player/presentation/bloc/music_bloc.dart';

class MockGetListMusicUseCase extends Mock implements GetListMusicUseCase {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  late MockGetListMusicUseCase getListMusicUseCase;
  late MockInputConverter mockInputConverter;
  late MusicBloc musicBloc;

  /// setup once
  setUpAll(() {
    getListMusicUseCase = MockGetListMusicUseCase();
    mockInputConverter = MockInputConverter();
  });

  /// setup each test
  setUp(() {
    musicBloc = MusicBloc(
      getListMusicUseCase: getListMusicUseCase,
      inputConverter: mockInputConverter,
    );
  });

  /// reset use case after each test
  tearDown(() {
    reset(getListMusicUseCase);
    reset(mockInputConverter);
  });

  test('initialState should be Empty', () {
    expect(
        musicBloc.state,
        const MusicEmpty(
          [],
          initialMessage,
          initialSubMessage,
        ));
  });

  group('MusicSearched', () {
    // The event takes in a String
    const tStr = 'dewa 19';
    // This is the successful output of the InputConverter
    const tTerm = 'dewa+19';
    // NumberTrivia instance is needed too, of course
    const tMusic1 = MusicModel(
      trackName: "Cinta 'Kan Membawamu Kembali",
      artistName: "Dewa 19",
      collectionName: "The Best of Dewa 19",
      artworkUrl100:
          "https://is5-ssl.mzstatic.com/image/thumb/Music125/v4/e7/58/8a/e7588af6-970c-75a8-d030-6ea46778adb6/source/100x100bb.jpg",
      previewUrl:
          "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/67/80/56/67805626-221d-8aec-07dd-a3b94e60e65e/mzaf_2602186213288694935.plus.aac.p.m4a",
    );
    const tMusic2 = MusicModel(
      trackName: "Kamulah Satu Satunya",
      artistName: "Dewa 19",
      collectionName: "The Best of Dewa 19",
    );
    const tListMusic = [tMusic1, tMusic2];

    void setUpMockInputConverterSuccess() =>
        when(() => mockInputConverter.stringToTerm(any()))
            .thenReturn(const Right(tTerm));

    void setUpMockInputConverterFailure() =>
        when(() => mockInputConverter.stringToTerm(any()))
            .thenReturn(Left(InvalidInputFailure()));

    blocTest<MusicBloc, MusicState>(
      'should call the InputConverter to convert string to term',
      build: () => musicBloc,
      setUp: () async {
        setUpMockInputConverterFailure();
      },
      act: (bloc) => bloc.add(const MusicSearched(tStr)),
      verify: (_) async {
        verify(() => mockInputConverter.stringToTerm(tStr));
      },
    );

    blocTest<MusicBloc, MusicState>(
      'should emit current state when the input is invalid',
      build: () => musicBloc,
      setUp: () async {
        setUpMockInputConverterFailure();
      },
      act: (bloc) => bloc.add(const MusicSearched(tStr)),
      expect: () => [
        const MusicEmpty(
          [],
          initialMessage,
          initialSubMessage,
        )
      ],
    );

    blocTest<MusicBloc, MusicState>('should get data from the use case',
        build: () => musicBloc,
        setUp: () async {
          setUpMockInputConverterSuccess();
          when(() => getListMusicUseCase(any()))
              .thenAnswer((_) async => const Right(tListMusic));
        },
        act: (bloc) => bloc.add(const MusicSearched(tStr)),
        verify: (_) {
          verify(() => getListMusicUseCase(tTerm));
        });

    blocTest<MusicBloc, MusicState>(
      'should emits [Loading, Success] when data is gotten successfully',
      build: () => musicBloc,
      setUp: () async {
        setUpMockInputConverterSuccess();
        when(() => getListMusicUseCase(any()))
            .thenAnswer((_) async => const Right(tListMusic));
      },
      act: (bloc) => bloc.add(const MusicSearched(tStr)),
      expect: () => <MusicState>[
        const MusicLoadInProgress([]),
        const MusicLoadSuccess(tListMusic)
      ],
    );

    blocTest<MusicBloc, MusicState>(
      'should emit [Loading, Empty(serverFailureMessage)] when getting data fails',
      build: () => musicBloc,
      setUp: () async {
        setUpMockInputConverterSuccess();
        when(() => getListMusicUseCase(any()))
            .thenAnswer((_) async => Left(ServerFailure()));
      },
      act: (bloc) => bloc.add(const MusicSearched(tStr)),
      expect: () => <MusicState>[
        const MusicLoadInProgress([]),
        const MusicEmpty(
          [],
          serverFailureMessage,
          serverFailureSubMessage,
        ),
      ],
    );

    blocTest<MusicBloc, MusicState>(
      'should emit [Loading, Empty(connectionFailureMessage)] when connection fails',
      build: () => musicBloc,
      setUp: () async {
        setUpMockInputConverterSuccess();
        when(() => getListMusicUseCase(any()))
            .thenAnswer((_) async => Left(ConnectionFailure()));
      },
      act: (bloc) => bloc.add(const MusicSearched(tStr)),
      expect: () => <MusicState>[
        const MusicLoadInProgress([]),
        const MusicEmpty(
          [],
          connectionFailureMessage,
          connectionFailureSubMessage,
        ),
      ],
    );
  });
}
