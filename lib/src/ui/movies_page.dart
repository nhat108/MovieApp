import 'package:flutter/material.dart';
import 'package:nux_movie/src/blocs/demo_bloc.dart';
import 'package:nux_movie/src/blocs/movies_bloc.dart';
import 'package:nux_movie/src/models/item_model.dart';
import 'package:nux_movie/src/utils/colors.dart';
import 'package:nux_movie/src/utils/error.dart';
import 'package:nux_movie/src/utils/search.dart';
import 'package:nux_movie/src/widgets/card_scroll.dart';
import 'package:nux_movie/src/widgets/list.dart';
import 'movie_detail.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({Key key}) : super(key: key);
  @override
  _MoviesPageState createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  LoadingBloc loadingBloc = new LoadingBloc(initCount: 0);
  @override
  void initState() {
    super.initState();
    bloc.fetchDiscoverMovies();
    bloc.fetchTrendingMovies();
    bloc.fetchTopRatedMovie();
    bloc.fetchUpCommingMovie();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    loadingBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(MovieColor.kPrimaryColor),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    alignment: AlignmentDirectional.centerStart,
                    padding: EdgeInsets.only(left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Trending',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 43,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Calibre-Semibold',
                              letterSpacing: 1),
                        ),
                        RawMaterialButton(
                          child: Icon(
                            Icons.search,
                            size: 26,
                            color: Colors.white,
                          ),
                          fillColor: Color(0xFF7E4CE3),
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(8),
                          onPressed: () {
                            showSearch(
                                context: context, delegate: MovieSearch());
                          },
                        ),
                      ],
                    ),
                  ),
                  StreamBuilder(
                    stream: bloc.trending,
                    builder: (context, AsyncSnapshot<ItemModel> snapshot) {
                      if (snapshot.hasData) {
                        loadingBloc.increment();
                        List<Result> results = snapshot.data.results;
                        return CardScroll(
                          results: results,
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.waiting)
                        return Container(
                          padding: EdgeInsets.all(50),
                          child: CircularProgressIndicator(),
                        );
                      if (snapshot.hasError)
                        return ErrorUtils.getErrorTrending(context);
                      return Container();
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        alignment: AlignmentDirectional.centerStart,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'DISCOVER',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Calibre-Semibold',
                              letterSpacing: 1),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'View all',
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 18,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  StreamBuilder(
                    stream: bloc.discover,
                    builder: (context, AsyncSnapshot<ItemModel> snapshot) {
                      if (snapshot.hasData) {
                        loadingBloc.increment();
                        List<Result> results = snapshot.data.results;
                        return ListMovie(
                          results: results,
                          kind: 'discover',
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.waiting)
                        return Container(
                          padding: EdgeInsets.all(50),
                          child: CircularProgressIndicator(),
                        );
                      if (snapshot.hasError) return Icon(Icons.error);
                      return Container();
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        alignment: AlignmentDirectional.centerStart,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'TOP RATED',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Calibre-Semibold',
                              letterSpacing: 1),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'View all',
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 18,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  StreamBuilder(
                    stream: bloc.topRated,
                    builder: (context, AsyncSnapshot<ItemModel> snapshot) {
                      if (snapshot.hasData) {
                        loadingBloc.increment();
                        return ListMovie(
                          results: snapshot.data.results,
                          kind: 'toprated',
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.waiting)
                        return Container(
                          padding: EdgeInsets.all(50),
                          child: CircularProgressIndicator(),
                        );
                      if (snapshot.hasError) return Icon(Icons.error);
                      return Container();
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        alignment: AlignmentDirectional.centerStart,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'UP COMMING',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Calibre-Semibold',
                              letterSpacing: 1),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'View all',
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 18,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  StreamBuilder(
                    stream: bloc.upComming,
                    builder: (context, AsyncSnapshot<ItemModel> snapshot) {
                      if (snapshot.hasData) {
                        loadingBloc.increment();
                        return ListMovie(
                          results: snapshot.data.results,
                          kind: 'upcomming',
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.waiting)
                        return Container(
                          padding: EdgeInsets.all(50),
                          child: CircularProgressIndicator(),
                        );
                      if (snapshot.hasError) return Icon(Icons.error);
                      return Container();
                    },
                  )
                ],
              ),
            ),
            StreamBuilder<int>(
              stream: loadingBloc.counterObservable,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data < 2)
                    return Container(
                        color: Color(MovieColor.kPrimaryColor),
                        alignment: Alignment.center,
                        child: CircularProgressIndicator());
                }
                return SizedBox();
              },
            )
          ],
        ),
      ),
    );
  }

  openMovieDetailPage({Result result, String heroTag}) {
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
