import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/feature/music_player/presentation/bloc/music_bloc.dart';
import 'package:music_player/feature/music_player/presentation/widgets/empty_state.dart';
import 'package:music_player/feature/music_player/presentation/widgets/music_item.dart';
import 'package:provider/provider.dart';

class MusicPlayerPage extends StatefulWidget {
  const MusicPlayerPage({Key? key}) : super(key: key);

  @override
  State<MusicPlayerPage> createState() => _MusicPlayerPageState();
}

class _MusicPlayerPageState extends State<MusicPlayerPage> {
  late AudioPlayer _player;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (str) {
            context.read<MusicBloc>().add(MusicSearched(str));
          },
        ),
      ),
      body: BlocBuilder<MusicBloc, MusicState>(
        builder: (context, state) {
          if (state is MusicEmpty) {
            return EmptyState(message: state.message);
          }

          var listMusic = state.listMusic;
          return ListView.builder(
              itemCount: listMusic.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var music = listMusic[index];
                return MusicItem(
                  music: music,
                  onTap: () async {
                    var url = music.previewUrl;
                    var isPlaying = _player.playing;

                    if (isPlaying) {
                      _player.pause();
                    } else if (url != null) {
                      await _player.setUrl(url);
                      _player.play();
                    }
                  },
                );
              });
        },
      ),
    );
  }
}
