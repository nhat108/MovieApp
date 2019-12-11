import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nux_movie/src/models/item_model.dart';
import 'package:nux_movie/src/utils/utils.dart';

class ItemMovieVertical extends StatelessWidget {
  final Result result;
  final String tag;
  final VoidCallback onTap;
  const ItemMovieVertical({Key key, this.result, this.tag,@required this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
   return GestureDetector(
      onTap: () {
        onTap();
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