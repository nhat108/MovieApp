import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nux_movie/src/models/item_model.dart';
import 'package:nux_movie/src/ui/movie_detail.dart';
import 'package:nux_movie/src/widgets/item_movie_vertical.dart';

class ListMovie extends StatefulWidget {
  final List<Result> results;
  final String kind;
  ListMovie({this.results, this.kind});
  @override
  State<StatefulWidget> createState() => ListMovieState();
}

class ListMovieState extends State<ListMovie> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.results.length,
        itemBuilder: (context, i) {
          String tag = '${widget.kind}+${widget.results[i].id}';
          Result result = widget.results[i];
          return Hero(
              tag: tag,
              child: ItemMovieVertical(
                result: result,
                tag: tag,
                onTap: () {
                  _navigateToMovieDetailPage(result: result, heroTag: tag);
                },
              ));
        },
      ),
    );
  }

  _navigateToMovieDetailPage({Result result, String heroTag}) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MovieDetail(
                result: result,
                heroTag: heroTag,
              )),
    );
  }
}
