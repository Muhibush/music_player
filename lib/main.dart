import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/core/utils/simple_bloc_observer.dart';
import 'package:music_player/feature/music_player/presentation/bloc/music_bloc.dart';
import 'package:music_player/feature/music_player/presentation/pages/music_player_page.dart';

import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// initial service locator
  await di.init();

  /// lock orientation to portraitUp
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  /// setup bloc observer
  BlocOverrides.runZoned(
    () => runApp(const MyApp()),

    /// bloc observer only active on debug mode
    blocObserver: kDebugMode ? SimpleBlocObserver() : null,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// setup screen utils base on design with width 360dp and height 640dp
    return ScreenUtilInit(
        designSize: const Size(360, 640),
        builder: () => MaterialApp(
              title: 'Music Player',
              theme: ThemeData(
                /// setup default font with Signika Negative
                textTheme: GoogleFonts.signikaNegativeTextTheme(
                  Theme.of(context).textTheme,
                ),

                /// setup dark mode
                brightness: Brightness.dark,
                primarySwatch: Colors.green,
              ),

              /// setup local bloc for MusicPlayerPage
              home: BlocProvider<MusicBloc>(
                create: (context) => di.sl<MusicBloc>(),
                child: MusicPlayerPage(
                  audioPlayer: di.sl<AudioPlayer>(),
                ),
              ),
            ));
  }
}
