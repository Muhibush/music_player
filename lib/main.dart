import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/core/utils/simple_bloc_observer.dart';
import 'package:music_player/feature/music_player/presentation/bloc/music_bloc.dart';
import 'package:music_player/feature/music_player/presentation/pages/music_player_page.dart';

import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  BlocOverrides.runZoned(
    () => runApp(const MyApp()),
    blocObserver: kDebugMode ? SimpleBlocObserver() : null,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Player',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<MusicBloc>(
        create: (context) => di.sl<MusicBloc>(),
        child: const MusicPlayerPage(),
      ),
    );
  }
}
