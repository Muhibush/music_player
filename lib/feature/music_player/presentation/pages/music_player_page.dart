import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/feature/music_player/presentation/bloc/music_bloc.dart';
import 'package:music_player/feature/music_player/presentation/widgets/empty_state.dart';
import 'package:music_player/feature/music_player/presentation/widgets/music_item.dart';
import 'package:provider/provider.dart';

class MusicPlayerPage extends StatelessWidget {
  final AudioPlayer audioPlayer;

  const MusicPlayerPage({Key? key, required this.audioPlayer})
      : super(key: key);

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
                    var isPlaying = audioPlayer.playing;

                    if (isPlaying) {
                      audioPlayer.pause();
                    } else if (url != null) {
                      await audioPlayer.setUrl(url);
                      audioPlayer.play();
                    }
                  },
                );
              });
        },
      ),
    );
  }
}
