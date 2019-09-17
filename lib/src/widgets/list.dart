import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nux_movie/src/models/item_model.dart';
import 'package:nux_movie/src/ui/movie_detail.dart';
import 'package:nux_movie/src/utils/utils.dart';

class ListMovie extends StatefulWidget {
  final List<Result> results;
  final String kind;
  ListMovie({this.results,this.kind});
  @override
  State<StatefulWidget> createState() => ListMovieState();
}

class ListMovieState extends State<ListMovie> {
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.8,
      child: Container(
        // padding: EdgeInsets.only(top: 3),
        height: 280,
         padding: EdgeInsets.symmetric(horizontal: 20),
        // margin: EdgeInsets.only(top:20),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.results.length,
          itemBuilder: (context, i) {
            String tag='${widget.kind}+${widget.results[i].id}';
            return Hero(
              tag: tag,
              child: getItemList(
                result: widget.results[i],
                tag: tag
              ),
            );
          },
        ),
      ),
    );
  }

  Widget getItemList({Result result,String tag}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MovieDetail(
                    result: result,
                    heroTag: tag,
                  )),
        );
      },
      child: Container(
        key: Key('{$result.id}'),
        width: 120,
        margin: EdgeInsets.all(7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: CachedNetworkImage(
                  imageUrl:
                      'https://image.tmdb.org/t/p/w185/${result.posterPath}',
                  width: 120,
                  height: 170,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              flex: 2,
              child: Text(
                '${result.title}',
                maxLines: 2,
                style: TextStyle(
                    color: Color(0xFFff877c),
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
              ),
            ),
            SizedBox(height: 3,),
            Expanded(
              flex: 1,
              child: Text(
                Utils.getGenresList(result.genreIds),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFffe3d8),
                    fontSize: 12),
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 20,
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Text('${result.voteAverage}')
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
