import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_player/feature/music_player/domain/entities/music.dart';
import 'package:music_player/feature/music_player/presentation/bloc/music_bloc.dart';
import 'package:shimmer/shimmer.dart';

class MusicControls extends StatelessWidget {
  final Music music;
  final Function(bool isPause) onTapIcon;

  const MusicControls({Key? key, required this.music, required this.onTapIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.w,
      width: 1.sw,
      alignment: Alignment.topCenter,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [
          Color(0xFF000000),
          Colors.transparent,
        ],
      )),
      child: Container(
        width: 344.w,
        height: 52.w,
        padding: EdgeInsets.symmetric(horizontal: 7.w),
        decoration: BoxDecoration(
            color: const Color(0xFF2C2F34),
            borderRadius: BorderRadius.all(Radius.circular(7.r))),
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
              width: 37.w,
              height: 37.w,
            ),
            SizedBox(width: 10.w),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    width: 250.w,
                    child: Text(
                      music.trackName,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                      ),
                    )),
                SizedBox(height: 2.w),
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
            BlocBuilder<MusicBloc, MusicState>(
              builder: (context, state) {
                var isPlaying = state.isPlaying;
                return GestureDetector(
                  onTap: () {
                    onTapIcon(isPlaying);
                  },
                  child: Container(
                    color: Colors.transparent,
                    width: 32.w,
                    child: Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.green,
                      size: 24.w,
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
