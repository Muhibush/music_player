import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_player/core/widgets/atoms/cache_network_image_atom.dart';
import 'package:music_player/feature/music_player/domain/entities/music.dart';

class MusicItemMolecule extends StatelessWidget {
  final Music music;
  final VoidCallback onTap;
  final bool isPlaying;

  const MusicItemMolecule(
      {Key? key,
      required this.music,
      required this.onTap,
      required this.isPlaying})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.w),
        color: Colors.transparent,
        alignment: Alignment.center,
        child: Row(
          children: [
            CacheNetworkImageAtom(
              imageUrl: music.artworkUrl100 ?? '',
              width: 42.w,
              height: 42.w,
            ),
            SizedBox(width: 10.w),
            Column(
              children: [
                SizedBox(
                    width: 250.w,
                    child: Text(
                      music.trackName,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: isPlaying ? Colors.green : Colors.white,
                        fontSize: 14.sp,
                      ),
                    )),
                SizedBox(height: 4.w),
                SizedBox(
                    width: 250.w,
                    child: Text(
                      music.artistName,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: const Color(0xFFB3B3B3),
                        fontSize: 12.sp,
                      ),
                    )),
              ],
            ),
            SizedBox(
              width: 30.w,
              child: Visibility(
                visible: isPlaying,
                child: Icon(
                  Icons.graphic_eq,
                  color: Colors.green,
                  size: 14.w,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
