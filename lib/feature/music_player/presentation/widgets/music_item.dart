import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_player/feature/music_player/domain/entities/music.dart';
import 'package:shimmer/shimmer.dart';

class MusicItem extends StatelessWidget {
  final Music music;
  final VoidCallback onTap;
  final bool isPlaying;

  const MusicItem(
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
            CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: music.artworkUrl100 ?? '',
              placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey.shade700,
                  highlightColor: Colors.grey.shade600,
                  child: Container(color: Colors.white)),
              errorWidget: (context, url, error) {
                return Container(
                    color: Colors.grey.shade700,
                    child: const Icon(
                      Icons.broken_image,
                      color: Colors.grey,
                    ));
              },
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
