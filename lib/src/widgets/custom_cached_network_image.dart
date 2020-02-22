import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:nux_movie/src/utils/utils.dart';

class CustomCachedNetWorkImage extends StatelessWidget {
  final String pixels;
  final double borderRadius;
  final double width;
  final double height;
  final String photoUrl;
  final Widget errorWidget;
  const CustomCachedNetWorkImage({Key key, this.pixels='w185', this.borderRadius=4, this.width, this.height,@required this.photoUrl, this.errorWidget}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        imageUrl: Utils.getPhotoUrlMovie(photoUrl,pixels: pixels),
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorWidget: (_,__,___)=>errorWidget,
      ),
    );
  }
}
