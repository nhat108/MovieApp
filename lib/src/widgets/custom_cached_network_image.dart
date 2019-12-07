import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

class CustomCachedNetWorkImage extends StatelessWidget {
  final int pixels;
  final double borderRadius;
  final double width;
  final double height;
  final String photoUrl;

  const CustomCachedNetWorkImage({Key key, this.pixels=185, this.borderRadius=4, this.width, this.height, this.photoUrl}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        imageUrl: 'https://image.tmdb.org/t/p/w$pixels/${photoUrl}',
        width: width,
        height: height,
        fit: BoxFit.cover,
      ),
    );
  }
}
