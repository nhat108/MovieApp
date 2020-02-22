import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nux_movie/src/blocs/movies_bloc.dart';
import 'package:nux_movie/src/models/item_model.dart';
import 'package:nux_movie/src/models/item_movie_gd.dart';
import 'package:nux_movie/src/services/firebase_service.dart';
import 'package:nux_movie/src/ui/play_video/video_player_screen.dart';
import 'package:nux_movie/src/utils/utils.dart';
import 'package:nux_movie/src/widgets/item_movie_horizontal.dart';
import 'package:nux_movie/src/widgets/waiting_widget.dart';

class WatchMovieList extends StatefulWidget {
  @override
  _WatchMovieListState createState() => _WatchMovieListState();
}

class _WatchMovieListState extends State<WatchMovieList> {
  FirebaseService _db = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('Movies'),
        ),
        child: Container(
          child: StreamBuilder<List<MovieGD>>(
            stream: _db.getAllMovies(),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return WaitingWidget();
              } else if (snapshot.hasData) {
                var movies = snapshot.data;
                return ListView.builder(
                  itemCount: movies.length,
                  itemBuilder: (_, index) {
                    return _item(movies[index]);
                  },
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  _navigateToPlayVideoPage(String link) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => VideoPlayerScreen(
                  videoUrl: Utils.getLinkMovieFromGD(link),
                )));
  }

  _item(MovieGD movieGD) {
    return Container(
      height: 175,
      child: FutureBuilder<Result>(
        future: bloc.fetchMovieDetail(movieGD.id),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            var result = snapshot.data;
            return ItemMovieHorizontal(
              result: result,
              onTap: () {
                _navigateToPlayVideoPage(movieGD.link);
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
