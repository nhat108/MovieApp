import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nux_movie/src/constants/colors.dart';
import 'package:nux_movie/src/models/item_model.dart';
import 'package:nux_movie/src/ui/movie_detail.dart';
import 'package:nux_movie/src/utils/error.dart';

import '../blocs/movies_bloc.dart';

class SearchCard extends StatefulWidget {
  final String query;
  final int page;
  SearchCard({this.query, this.page});
  @override
  _SearchCardState createState() => _SearchCardState();
}

class _SearchCardState extends State<SearchCard> {
  @override
  void initState() {
    super.initState();
    bloc.fetchSearchMovie(widget.query, widget.page);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(kPrimaryColor),
      child: StreamBuilder<ItemModel>(
        stream: bloc.searchMovie,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data.results.length > 0) {
            return getMovieCard(snapshot.data.results, context);
          } else if (snapshot.hasError) {
            return Center(
              child: Icon(Icons.error),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'No results found',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'It seems we can’t find any results based on your search',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    // fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 117, 117, 117),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

getMovieCard(List<Result> results, BuildContext context) {
  return GridView.count(
    crossAxisCount: 3,
    childAspectRatio: 3 / 4.5,
    children: List.generate(results.length - 1, (i) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MovieDetail(
                      result: results[i],
                      heroTag: '${results[i].id}',
                    )),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.all(4),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: CachedNetworkImage(
            
              imageUrl:
                  'https://image.tmdb.org/t/p/w500/${results[i].posterPath}',
              placeholder: (context, url) => Container(
                height: 200,
                width: 130,
                color: Colors.grey,
              ),
              errorWidget: (context, url, error) => Container(child:ErrorUtils.getErrorPoster(),height: 200,width: 130,),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    }),
  );
}
