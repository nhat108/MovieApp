import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nux_movie/src/blocs/movie_bloc.dart';
import 'package:nux_movie/src/blocs/movie_event.dart';
import 'package:nux_movie/src/blocs/movie_state.dart';
import 'package:nux_movie/src/constants/colors.dart';
import 'package:nux_movie/src/constants/enums.dart';
import 'package:nux_movie/src/models/item_model.dart';
import 'package:http/http.dart' as http;
import 'package:nux_movie/src/widgets/item_movie_horizontal.dart';
import 'package:nux_movie/src/widgets/waiting_widget.dart';

import 'movie_detail.dart';

class ViewAllMovie extends StatefulWidget {
  final String title;
  final TypeOfMovie type;

  const ViewAllMovie({Key key, this.title, this.type}) : super(key: key);
  @override
  _ViewAllMovieState createState() => _ViewAllMovieState();
}

class _ViewAllMovieState extends State<ViewAllMovie> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  MovieBloc _movieBloc;

  @override
  void initState() {
    _movieBloc = MovieBloc(httpClient: http.Client(), type: widget.type);
    _scrollController.addListener(_onScroll);
    _movieBloc.dispatch(Fetch());
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _movieBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CupertinoPageScaffold(
          backgroundColor: Color(kPrimaryColor),
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Color(kPrimaryDarkColor).withOpacity(0.5),
        middle: Text(widget.title),
      ),
      child: BlocBuilder(
        bloc: _movieBloc,
        builder: (context, state) {
          if (state is MovieUninitialized) {
            return Center(child: WaitingWidget());
          }
          if (state is MovieLoaded) {
            print('state:' + state.results.length.toString());
            return ListView.builder(
              itemBuilder: (context, index) {
                return index >= state.results.length
                    ? _bottomLoader()
                    : _item(state.results[index]);
              },
              itemCount: state.hasReachedMax
                  ? state.results.length
                  : state.results.length + 1,
              controller: _scrollController,
            );
          }
          return Container();
        },
      ),
    ));
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _movieBloc.dispatch(Fetch());
    }
  }

  _bottomLoader() {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: Center(
          child: SizedBox(
            width: 33,
            height: 33,
            child: CupertinoActivityIndicator(),
          ),
        ),
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

  _item(Result result) {
    return ItemMovieHorizontal(
      result: result,
      onTap: (){
         _navigateToMovieDetailPage(result: result,heroTag: result.id.toString());
      },
    );
  }
}
