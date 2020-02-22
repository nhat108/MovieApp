import 'package:flutter/material.dart';
import 'package:nux_movie/src/models/item_model.dart';
import 'package:nux_movie/src/utils/utils.dart';
import 'package:nux_movie/src/widgets/waiting_widget.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ViewPhotoPage extends StatefulWidget {
  final List<Poster> photos;
  final int index;

  const ViewPhotoPage({Key key, this.photos, this.index}) : super(key: key);
  @override
  _ViewPhotoPageState createState() => _ViewPhotoPageState();
}

class _ViewPhotoPageState extends State<ViewPhotoPage> {
  List<Poster> get photos => widget.photos;
  PageController _controller;
  var width = 0.0;
  @override
  void initState() {
    _controller = PageController(initialPage: widget.index);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      width = MediaQuery.of(context).size.width;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        child: PhotoViewGallery.builder(
      scrollPhysics: const BouncingScrollPhysics(),
      builder: (BuildContext context, int index) {
        return PhotoViewGalleryPageOptions(
          imageProvider: NetworkImage(Utils.getPhotoUrlMovie(photos[index].filePath,pixels: 'w780')),
          initialScale: PhotoViewComputedScale.contained ,
          heroAttributes: PhotoViewHeroAttributes(tag: photos[index].filePath),
        );
      },
      itemCount: photos.length,
      loadingChild: WaitingWidget(),
      pageController: _controller,
    ));
  }
}
