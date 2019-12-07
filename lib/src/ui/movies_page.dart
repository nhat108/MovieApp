import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nux_movie/src/blocs/movies_bloc.dart';
import 'package:nux_movie/src/contants/colors.dart';
import 'package:nux_movie/src/contants/enums.dart';
import 'package:nux_movie/src/models/item_model.dart';
import 'package:nux_movie/src/ui/search_movie_delegate.dart';
import 'package:nux_movie/src/ui/view_all_movie_page.dart';
import 'package:nux_movie/src/utils/store_search_query.dart';
import 'package:nux_movie/src/widgets/card_scroll.dart';
import 'package:nux_movie/src/widgets/list_movie.dart';
import 'package:nux_movie/src/widgets/waiting_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({Key key}) : super(key: key);
  @override
  _MoviesPageState createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  @override
  void initState() {
    super.initState();
    bloc.fetchDiscoverMovies(1);
    bloc.fetchTrendingMovies();
    bloc.fetchTopRatedMovie(1);
    bloc.fetchUpCommingMovie(1);
  }

  @override
  void dispose() {
    print('dispose movies page!!!');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(kPrimaryColor),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 40),
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
                    onPressed: () async {
                      SharedPreferences sharedPreferences =
                          await SharedPreferences.getInstance();
                      showSearch(
                          context: context,
                          delegate: SearchMovieDelegate(
                              StoreSearchQuery(sharedPreferences)));
                    },
                  ),
                ],
              ),
            ),
            StreamBuilder<ItemModel>(
              stream: bloc.trending,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Result> results = snapshot.data.results;
                  return CardScroll(
                    results: results,
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting)
                  return WaitingWidget();

                return Container();
              },
            ),
            buildTitle('DISCOVER', TypeOfMovie.DISCOVER),
            SizedBox(
              height: 5,
            ),
            StreamBuilder<ItemModel>(
              stream: bloc.discover,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Result> results = snapshot.data.results;
                  return ListMovie(
                    results: results,
                    kind: 'discover',
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting)
                  return WaitingWidget();
                return Container();
              },
            ),
            SizedBox(
              height: 5,
            ),
            buildTitle('TOP RATED', TypeOfMovie.TOPRATED),
            SizedBox(
              height: 5,
            ),
            StreamBuilder(
              stream: bloc.topRated,
              builder: (context, AsyncSnapshot<ItemModel> snapshot) {
                if (snapshot.hasData) {
                  return ListMovie(
                    results: snapshot.data.results,
                    kind: 'toprated',
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting)
                  return WaitingWidget();
                return Container();
              },
            ),
            SizedBox(
              height: 5,
            ),
            buildTitle('UP COMING', TypeOfMovie.UPCOMING),
            SizedBox(
              height: 5,
            ),
            StreamBuilder<ItemModel>(
              stream: bloc.upComming,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListMovie(
                    results: snapshot.data.results,
                    kind: 'upcomming',
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting)
                  return WaitingWidget();
                return Container();
              },
            )
          ],
        ),
      ),
    );
  }

  Widget buildTitle(String title, TypeOfMovie type) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Calibre-Semibold',
            letterSpacing: 1),
      ),
      trailing: Text(
        'View all',
        style: TextStyle(
          color: Colors.blueAccent,
          fontSize: 18,
        ),
      ),
      onTap: () {
        _navigateToViewAllMoviePage(title, type);
      },
    );
  }

  _navigateToViewAllMoviePage(String title, type) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ViewAllMovie(title: title, type: type)));
  }
}
