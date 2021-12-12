import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/core/widgets/atoms/text_field_atom.dart';
import 'package:music_player/core/widgets/molecules/empty_state_molecule.dart';
import 'package:music_player/core/widgets/molecules/music_item_molecule.dart';
import 'package:music_player/feature/music_player/presentation/bloc/music_bloc.dart';
import 'package:music_player/feature/music_player/presentation/widgets/molecules/music_controls.dart';

class MusicPlayerPage extends StatelessWidget {
  final AudioPlayer audioPlayer;

  const MusicPlayerPage({Key? key, required this.audioPlayer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        elevation: 0,
        title: TextFieldAtom(
          hintText: 'Search artist',
          onChanged: (str) {
            context.read<MusicBloc>().add(MusicSearched(str));
          },
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          BlocConsumer<MusicBloc, MusicState>(
            listener: (context, state) async {
              if (state is MusicPlayed) {
                var url = state.playedMusic?.previewUrl;
                if (url != null) {
                  await audioPlayer.setUrl(url);
                  audioPlayer.play();
                }
              } else if (state is MusicPaused) {
                audioPlayer.pause();
              }
            },
            builder: (context, state) {
              if (state is MusicEmpty) {
                return EmptyStateMolecule(
                  message: state.message,
                  subMessage: state.subMessage,
                );
              }

              var listMusic = state.listMusic;
              var playedMusic = state.playedMusic;

              return ListView.builder(
                  itemCount: listMusic.length,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var music = listMusic[index];
                    var isPlaying = playedMusic?.previewUrl == music.previewUrl;
                    return MusicItemMolecule(
                      music: music,
                      isPlaying: isPlaying,
                      onTap: () {
                        context.read<MusicBloc>().add(MusicPlayPressed(music));
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                      },
                    );
                  });
            },
          ),
          BlocBuilder<MusicBloc, MusicState>(
            builder: (context, state) {
              var playedMusic = state.playedMusic;
              if (playedMusic != null) {
                return Positioned(
                    bottom: 0,
                    child: MusicControls(
                      onTapIcon: (isPlaying) {
                        if (isPlaying) {
                          context.read<MusicBloc>().add(MusicPausePressed());
                        } else {
                          context
                              .read<MusicBloc>()
                              .add(MusicPlayPressed(playedMusic));
                        }
                      },
                      music: playedMusic,
                    ));
              }
              return const SizedBox.shrink();
            },
          )
        ],
      ),
    );
  }
}
