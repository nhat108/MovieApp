import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nux_movie/src/models/item_model.dart';
import 'package:nux_movie/src/ui/movie_detail.dart';
import 'package:nux_movie/src/utils/error.dart';

class RecommendationsList extends StatefulWidget {
  final List<Result> results;
  RecommendationsList({this.results});
  @override
  _RecommendationsListState createState() => _RecommendationsListState();
}

class _RecommendationsListState extends State<RecommendationsList> {
  PageController _pageController;
  int currentPage = 0;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(
        initialPage: currentPage, keepPage: false, viewportFraction: 0.5);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: AlignmentDirectional.topCenter,
        height: 250,
        child: PageView.builder(
          itemCount: widget.results.length,
          onPageChanged: (value) {
            setState(() {
              currentPage = value;
            });
          },
          controller: _pageController,
          itemBuilder: (context, index) => animateItemBuilder(
            index: index,
          ),
        ),
      ),
    );
  }

  animateItemBuilder({int index}) {
    return Hero(
      tag: '${widget.results[index].id}',
      child: GestureDetector(
        onTap: () {
          openMovieDetail(result: widget.results[index]);
        },
        child: AnimatedBuilder(
          animation: _pageController,
          builder: (context, child) {
            double value = 1;
            if (_pageController.position.haveDimensions) {
              value = _pageController.page - index;
              value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
            }
            return Center(
              child: SizedBox(
                  height: Curves.easeOut.transform(value) * 200,
                  width: Curves.easeOut.transform(value) * 300,
                  child: child),
            );
          },
          child: Container(
            margin: EdgeInsets.all(10),
            child: Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: 'https://image.tmdb.org/t/p/w500/' +
                        '${widget.results[index].posterPath}',
                 
                    errorWidget: (context, url, error) => ErrorUtils.getErrorPoster(),
                  ),
                ),
                Positioned(
                  width: 120,
                  left: 2,
                  bottom: 3,
                  child: Text(
                    '${widget.results[index].title}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFffe3d8)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  openMovieDetail({Result result}) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MovieDetail(
                result: result,
                heroTag: '${result.id}',
              )),
    );
  }
}
