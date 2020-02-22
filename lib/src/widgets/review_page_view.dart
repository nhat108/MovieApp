import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nux_movie/src/models/item_video.dart';
import 'package:nux_movie/src/utils/error.dart';
import 'package:nux_movie/src/utils/utils.dart';
import 'package:provider/provider.dart';

class ReviewPageView extends StatefulWidget {
  final Function onTap;
  ReviewPageView({this.onTap});
  @override
  _ReviewPageViewState createState() => _ReviewPageViewState();
}

class _ReviewPageViewState extends State<ReviewPageView> {
  var currentPage = 0;
  PageController _pageController =
      PageController(initialPage: 0, keepPage: false, viewportFraction: 0.8);
  AudioPlayer _audioPlayer = AudioPlayer();
  List<Video> videos;
  var width;
  var height;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    this.videos = Provider.of<List<Video>>(context);
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    playSoundTrack(0);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }
  @override
  void deactivate(){
    print('deactivate was called');
    super.deactivate();

  }
  Future<int> playSoundTrack(int index) async {
    return _audioPlayer.play(videos[index].soundtrack);
  }

  @override
  Widget build(BuildContext context) {
    if (videos == null)
      return Center(
        child: CircularProgressIndicator(),
      );
    return Scaffold(
      body: Stack(
        children: <Widget>[
          AnimatedContainer(
            duration: Duration(milliseconds: 500),
            child: Stack(
              children: <Widget>[
                Container(
                  child: CachedNetworkImage(
                    imageUrl: videos[currentPage].image,
                    width: width,
                    height: height,
                    errorWidget: (context, url, error) => Container(
                      width: width,
                      height: height,
                      child: ErrorUtils.getErrorBackgroundPerson(),
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: Container(
                    color: Colors.black.withOpacity(0),
                  ),
                )
              ],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: height * 0.6,
                child: PageView.builder(
                  itemBuilder: (context, index) {
                    return Hero(
                      tag: 'video' + videos[index].url,
                      child: _itemVideo(
                          index: index,
                          color: int.parse(videos[index].color),
                          image: videos[index].image,
                          onTap: () {
                            widget.onTap(
                                url: videos[index].url,
                                thumnail: videos[index].thumnail);
                          }),
                    );
                  },
                  itemCount: videos.length,
                  controller: _pageController,
                  pageSnapping: true,
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                    playSoundTrack(value);
                  },
                  physics: ClampingScrollPhysics(),
                ),
              ),
              _detailsBuilder(currentPage, videos[currentPage])
            ],
          ),
        ],
      ),
    );
  }

  Widget _detailsBuilder(index, Video video) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = _pageController.page - index;
          value = (1 - (value.abs() * 0.5)).clamp(0.0, 1.0);
        }
        return Expanded(
          child: Transform.translate(
            offset: Offset(0, 100 + (-value * 100)),
            child: Opacity(
              opacity: value,
              child: Container(
                padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      video.title,
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      video.description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Container(
                      width: 80.0,
                      height: 5.0,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        Utils.launchURL(video.website);
                      },
                      child: Text(
                        "Read More",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w900),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  _itemVideo({int index, String image, int color, onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedBuilder(
        animation: _pageController,
        builder: (context, child) {
          double value = 1;
          if (_pageController.position.haveDimensions) {
            value = _pageController.page - index;
            value = (1 - (value.abs() * 0.5)).clamp(0.0, 1.0);
            return Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: const EdgeInsets.only(
                    left: 25.0, right: 25.0, bottom: 10.0),
                height: Curves.easeIn.transform(value) * 600,
                child: child,
              ),
            );
          } else {
            return Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: const EdgeInsets.only(
                    left: 25.0, right: 25.0, bottom: 10.0),
                height:
                    Curves.easeIn.transform(index == 0 ? value : value * 0.5) *
                        600,
                child: child,
              ),
            );
          }
        },
        child: Material(
          elevation: 5.0,
          color: Color(color),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10))),
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15)),
                child: CachedNetworkImage(
                  imageUrl: image,
                  width: 500,
                  errorWidget: (context, error, url) =>
                      ErrorUtils.getErrorPoster(),
                  placeholder: (context, url) => ErrorUtils.getErrorPoster(),
                  fit: BoxFit.cover,
                )),
          ),
        ),
      ),
    );
  }
}
