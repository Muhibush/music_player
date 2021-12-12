import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CacheNetworkImageAtom extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;

  const CacheNetworkImageAtom(
      {Key? key,
      required this.imageUrl,
      required this.width,
      required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      imageUrl: imageUrl,
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
      width: width,
      height: height,
    );
  }
}
