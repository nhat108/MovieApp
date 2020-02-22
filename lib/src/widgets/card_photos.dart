import 'package:flutter/material.dart';
import 'package:nux_movie/src/models/item_model.dart';
import 'package:nux_movie/src/widgets/custom_cached_network_image.dart';
import 'package:nux_movie/src/widgets/custom_text.dart';

class CardPhotos extends StatefulWidget {
  final Function onPhotoTap;
  final List<Poster> photos;
  const CardPhotos({Key key, this.onPhotoTap, this.photos}) : super(key: key);
  @override
  _CardPhotosState createState() => _CardPhotosState();
}

class _CardPhotosState extends State<CardPhotos> {
  List<Poster> get photos => widget.photos;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildCardPhotos(),
    );
  }

  Widget _buildCardPhotos() {
    return Container(
      margin: EdgeInsets.all(5),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: <Widget>[
            if (photos.length <= 3)
              for (int i = 0; i < photos.length; i++) _buildPhoto(photos[i], i)
            else if (photos.length > 3)
              for (int i = 0; i <= 2; i++) _buildPhoto(photos[i], i),
            if (photos.length > 3) _buildPhotoMore(photos[3], photos.length - 3)
          ],
        ),
      ),
    );
  }

  Widget _buildPhoto(Poster poster, int index) {
    return GestureDetector(
      onTap: () {
        widget.onPhotoTap(index);
      },
      child: Container(
        margin: EdgeInsets.all(3),
        child: CustomCachedNetWorkImage(
          photoUrl: poster.filePath,
          borderRadius: 0,
          height: 80,
          width: 80,
        ),
      ),
    );
  }

  Widget _buildPhotoMore(Poster poster, int lenght) {
    return GestureDetector(
      onTap: () {
        widget.onPhotoTap(3);
      },
      child: Stack(
        children: <Widget>[
          _buildPhoto(poster, 3),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(3),
            width: 80,
            height: 80,
            color: Colors.black.withOpacity(0.5),
            child: CustomText('$lenght+'),
          ),
        ],
      ),
    );
  }
}
