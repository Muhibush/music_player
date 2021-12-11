import 'package:flutter/material.dart';
import 'package:music_player/feature/music_player/domain/entities/music.dart';

class MusicItem extends StatelessWidget {
  final Music music;
  final VoidCallback onTap;

  const MusicItem({Key? key, required this.music, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        height: 100,
        alignment: Alignment.center,
        child: Text(music.trackName),
      ),
    );
  }
}
